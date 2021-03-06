﻿﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using JewelOfIndiaBuilder.Models;

namespace JewelOfIndiaBuilder.Controllers
{
    public class ApartmentAdminController : Controller
    {
        private JewelOfIndiaEntities db = new JewelOfIndiaEntities();

        // GET: /ApartmentAdmin/
        public bool Redirect()
        {
            return !ApplicationSecurity.CheckUser(Session["UserType"].ToString(), Session["IsAdmin"].ToString(), "APARTMENT");
        }

        public ActionResult Index()
        {
            if (Redirect())
                return RedirectToAction("../Home");
            var apartments = db.Apartments.Include(a => a.Tower);
            return View(apartments.ToList());
        }

        // GET: /ApartmentAdmin/Details/5
        public ActionResult Details(long? id)
        {
            if (Redirect())
                return RedirectToAction("../Home");
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Apartment apartment = db.Apartments.Find(id);
            if (apartment == null)
            {
                return HttpNotFound();
            }
            return View(apartment);
        }

        // GET: /ApartmentAdmin/Create
        public ActionResult Create()
        {
            if (Redirect())
                return RedirectToAction("../Home");
            ViewBag.TowerId = new SelectList(db.Towers, "Id", "TowerName");
            return View();
        }

        // POST: /ApartmentAdmin/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,BedRoom,Bathroom,Garage,Description,FloorLevel,Address,Area,TowerId")] Apartment apartment)
        {
            if (Redirect())
                return RedirectToAction("../Home");
            if (ModelState.IsValid)
            {
                db.Apartments.Add(apartment);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.TowerId = new SelectList(db.Towers, "Id", "TowerName", apartment.TowerId);
            return View(apartment);
        }

        // GET: /ApartmentAdmin/Edit/5
        public ActionResult Edit(long? id)
        {
            if (Redirect())
                return RedirectToAction("../Home");
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Apartment apartment = db.Apartments.Find(id);
            if (apartment == null)
            {
                return HttpNotFound();
            }
            ViewBag.TowerId = new SelectList(db.Towers, "Id", "TowerName", apartment.TowerId);
            return View(apartment);
        }

        // POST: /ApartmentAdmin/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,BedRoom,Bathroom,Garage,Description,FloorLevel,Address,Area,TowerId")] Apartment apartment)
        {
            if (Redirect())
                return RedirectToAction("../Home");
            if (ModelState.IsValid)
            {
                db.Entry(apartment).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.TowerId = new SelectList(db.Towers, "Id", "TowerName", apartment.TowerId);
            return View(apartment);
        }

        // GET: /ApartmentAdmin/Delete/5
        public ActionResult Delete(long? id)
        {
            if (Redirect())
                return RedirectToAction("../Home");
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Apartment apartment = db.Apartments.Find(id);
            if (apartment == null)
            {
                return HttpNotFound();
            }
            return View(apartment);
        }

        // POST: /ApartmentAdmin/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(long id)
        {
            if (Redirect())
                return RedirectToAction("../Home");
            Apartment apartment = db.Apartments.Find(id);
            db.Apartments.Remove(apartment);
            db.SaveChanges();
            return RedirectToAction("Index");
        }
        protected override void OnException(ExceptionContext filterContext)
        {
            if (filterContext != null && filterContext.Exception != null)
            {
                Elmah.ErrorSignal.FromCurrentContext().Raise(filterContext.Exception);
                filterContext.ExceptionHandled = true;
                this.View("Error").ViewData["Exception"] = filterContext.Exception.Message;
                this.View("Error").ExecuteResult(this.ControllerContext);
            }
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