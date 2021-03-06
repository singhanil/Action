﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Validation;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using JewelOfIndiaBuilder.Models;

namespace JewelOfIndiaBuilder.Controllers
{
    public class UserAdminController : Controller
    {
        private JewelOfIndiaEntities db = new JewelOfIndiaEntities();

        // GET: /UserAdmin/
        public ActionResult Index()
        {
            if (!ApplicationSecurity.CheckUser(Session["UserType"].ToString(), Session["IsAdmin"].ToString(), "USER"))
            {
                return RedirectToAction("../Home");
            }
            return View(db.Users.ToList());//
        }

        public ViewResult Login()
        {
            return View();
        }

        public ViewResult ChangePassword()
        {
            //var user = db.Users.FirstOrDefault(x => x.UserName == Session["UserName"].ToString());

            return View();
        }

        
        public ViewResult ForgotPassword()
        {
            return View();
        }
        public ActionResult Logoff()
        {
            Session.Clear();
            Session.Abandon();
            return RedirectToAction("../Home");
        }

        [HttpPost]
        public ActionResult ForgotPassword(User user)
        {
            var validUser = db.Users.FirstOrDefault(x => x.UserName == user.UserName && x.Answer.ToLower().Trim()== user.Answer.ToLower().Trim());

            if (validUser == null)
            {
                return RedirectToAction("ForgotPassword");
            }
            db.Entry(validUser).State = System.Data.Entity.EntityState.Modified;
            var salt = System.Web.Helpers.Crypto.GenerateSalt();
            var saltedPassword = user.Password + salt;
            var hashedPassword = System.Web.Helpers.Crypto.HashPassword(saltedPassword);
            validUser.Password = hashedPassword;
            validUser.Salt = salt;
            db.SaveChanges();
            return RedirectToAction("Login");
        }

        [HttpPost]
        public ActionResult ChangePassword(User user)
        {
            bool validEmail = db.Users.Any(x => x.UserName == user.UserName);

            if (!validEmail)
            {
                return RedirectToAction("ChangePassword");
            }
           

            var userToUpdate= db.Users.FirstOrDefault(x => x.UserName == user.UserName);

            var newSalt = System.Web.Helpers.Crypto.GenerateSalt();
            var saltedPassword = user.newPassword + newSalt;
            var hashedPassword = System.Web.Helpers.Crypto.HashPassword(saltedPassword);
            userToUpdate.Password = hashedPassword;
            userToUpdate.Salt = newSalt;

            db.Entry(userToUpdate).State = System.Data.Entity.EntityState.Modified;
            db.SaveChanges();

            return RedirectToAction("../Home");
        }

        [HttpPost]
        public ActionResult Login(User user)
        {
            
            bool validEmail = db.Users.Any(x => x.UserName == user.UserName);

            if (!validEmail)
            {
                return RedirectToAction("Login");
            }

            //var salt = GetSaltForUserFromDatabase(username);
            //var hashedPassword = GetHashedPasswordForUserFromDatabase(username);
            //var saltedPassword = password + salt;

            var validUser = db.Users.FirstOrDefault(x => x.UserName == user.UserName);

            string salt = validUser.Salt;


            string password = validUser.Password;

            bool? isAdmin = validUser.IsOwner;



            bool passwordMatches = System.Web.Helpers.Crypto.VerifyHashedPassword(password, user.Password + salt);

            if (!passwordMatches)
            {
                return RedirectToAction("Login");
            }

            string authId = Guid.NewGuid().ToString();

            Session["AuthID"] = authId;
            Session["IsAdmin"] = isAdmin;
            Session["UserType"] = validUser.UserType.UserTypeCode;
            Session["UserName"] = validUser.UserName;

            return RedirectToAction("../Home");
        }

        // GET: /UserAdmin/Details/5
        public ActionResult Details(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            User user = db.Users.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            return View(user);
        }

        // GET: /UserAdmin/Create
        public ActionResult Create()
        {
            ViewBag.UserTypeId = new SelectList(db.UserTypes, "Id", "UserTypeCode");
            return View();
        }

        // POST: /UserAdmin/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,UserName,Password,Salt,Question,Answer,EmailId,IsOwner,MobileNo,DOB,UserTypeId")] User user)
        {

            if (!ApplicationSecurity.CheckUser(Session["UserType"].ToString(), Session["IsAdmin"].ToString(), "USER"))
            {
                return RedirectToAction("../Home");
            }
            if (ModelState.IsValid)
            {
                var salt = System.Web.Helpers.Crypto.GenerateSalt();
                var saltedPassword = user.Password + salt;
                var hashedPassword = System.Web.Helpers.Crypto.HashPassword(saltedPassword);
                user.Password = hashedPassword;
                user.Salt = salt;

                db.Users.Add(user);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.UserTypeId = new SelectList(db.UserTypes, "Id", "UserTypeCode",user.UserTypeId);
            return View(user);
        }

        // GET: /UserAdmin/Edit/5
        public ActionResult Edit(long? id)
        {
            if (!ApplicationSecurity.CheckUser(Session["UserType"].ToString(), Session["IsAdmin"].ToString(), "USER"))
            {
                return RedirectToAction("../Home");
            }
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            User user = db.Users.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            ViewBag.UserTypeId = new SelectList(db.UserTypes, "Id", "UserTypeCode", user.UserTypeId);
            return View(user);
        }

        // POST: /UserAdmin/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="Id,UserName,Password,Salt,Question,Answer,EmailId,IsOwner,MobileNo,DOB,UserTypeId")] User user)
        {
            if (!ApplicationSecurity.CheckUser(Session["UserType"].ToString(), Session["IsAdmin"].ToString(), "USER"))
            {
                return RedirectToAction("../Home");
            }
            string salt = db.Users.Where(x => x.UserName == user.UserName)
                             .Select(x => x.Salt)
                             .Single();


            string password = db.Users.Where(x => x.UserName == user.UserName)
                                         .Select(x => x.Password)
                                         .Single();


            user.Salt = salt;
            user.Password = password;

            if (ModelState.IsValid)
            {
                db.Entry(user).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.UserTypeId = new SelectList(db.UserTypes, "Id", "UserTypeCode", user.UserTypeId);
            return View(user);
        }

        // GET: /UserAdmin/Delete/5
        public ActionResult Delete(long? id)
        {
            if (!ApplicationSecurity.CheckUser(Session["UserType"].ToString(), Session["IsAdmin"].ToString(), "USER"))
            {
                return RedirectToAction("../Home");
            }
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            User user = db.Users.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            return View(user);
        }

        // POST: /UserAdmin/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(long id)
        {
            if (!ApplicationSecurity.CheckUser(Session["UserType"].ToString(), Session["IsAdmin"].ToString(), Session["UserType"].ToString()))
            {
                return RedirectToAction("../Home");
            }
            User user = db.Users.Find(id);
            db.Users.Remove(user);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
