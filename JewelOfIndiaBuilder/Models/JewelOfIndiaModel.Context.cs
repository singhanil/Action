﻿//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace JewelOfIndiaBuilder.Models
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Objects;
    using System.Data.Objects.DataClasses;
    using System.Linq;

    public partial class JewelOfIndiaEntities : DbContext
    {
        public JewelOfIndiaEntities()
            : base("name=JewelOfIndiaEntities")
        {
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }

        public DbSet<Apartment> Apartments { get; set; }
        public DbSet<ApartmetSale> ApartmetSales { get; set; }
        public DbSet<Customer> Customers { get; set; }
        public DbSet<Feature> Features { get; set; }
        public DbSet<FeatureType> FeatureTypes { get; set; }
        public DbSet<Location> Locations { get; set; }
        public DbSet<Property> Properties { get; set; }
        public DbSet<PropertyType> PropertyTypes { get; set; }
        public DbSet<Tower> Towers { get; set; }
        public DbSet<Visual> Visuals { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<ApartmentSalesType> ApartmentSalesTypes { get; set; }
        public DbSet<UserType> UserTypes { get; set; }

    }
}
