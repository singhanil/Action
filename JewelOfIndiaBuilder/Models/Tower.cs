//------------------------------------------------------------------------------
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
    using System.Collections.Generic;
    
    public partial class Tower
    {
        public Tower()
        {
            this.Apartments = new HashSet<Apartment>();
            this.Features = new HashSet<Feature>();
        }
    
        public long Id { get; set; }
        public long PropertyId { get; set; }
        public string TowerName { get; set; }
        public string TowerDirection { get; set; }
        public string Description { get; set; }
    
        public virtual ICollection<Apartment> Apartments { get; set; }
        public virtual Property Property { get; set; }
        public virtual ICollection<Feature> Features { get; set; }
    }
}
