﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;
using JewelOfIndiaBuilder.Models;
using EntityState = System.Data.Entity.EntityState;

namespace JewelOfIndiaBuilder.Controllers
{
    public class UserController : ApiController
    {
        private JewelOfIndiaEntities db = new JewelOfIndiaEntities();

        public List<sp_GetUser_Result> GetUser(long id)
        {
            var users = db.Database.SqlQuery<sp_GetUser_Result>("exec dbo.sp_GetUser {0}", id).ToList<sp_GetUser_Result>();

            return users;
        }

        // GET api/User
        public IQueryable<User> GetUsers()
        {
            return db.Users;
        }

       /* // GET api/User/5
        [ResponseType(typeof(User))]
        public IHttpActionResult GetUser(long id)
        {
            User user = db.Users.Find(id);
            if (user == null)
            {
                return NotFound();
            }

            return Ok(user);
        }*/

        // PUT api/User/5
        public IHttpActionResult PutUser(long id, User user)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != user.Id)
            {
                return BadRequest();
            }

            db.Entry(user).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!UserExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST api/User
        [ResponseType(typeof(User))]
        public IHttpActionResult PostUser(User user)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Users.Add(user);
            db.SaveChanges();

            return CreatedAtRoute("DefaultApi", new { id = user.Id }, user);
        }

        // DELETE api/User/5
        [ResponseType(typeof(User))]
        public IHttpActionResult DeleteUser(long id)
        {
            User user = db.Users.Find(id);
            if (user == null)
            {
                return NotFound();
            }

            db.Users.Remove(user);
            db.SaveChanges();

            return Ok(user);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool UserExists(long id)
        {
            return db.Users.Count(e => e.Id == id) > 0;
        }
    }
}