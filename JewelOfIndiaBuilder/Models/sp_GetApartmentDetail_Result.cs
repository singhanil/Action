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
    
    public partial class sp_GetApartmentDetail_Result
    {
        public long Id { get; set; }
        public Nullable<int> BedRoom { get; set; }
        public Nullable<int> Bathroom { get; set; }
        public Nullable<int> Garage { get; set; }
        public string Description { get; set; }
        public Nullable<short> FloorLevel { get; set; }
        public string Address { get; set; }
        public Nullable<long> Area { get; set; }
        public Nullable<long> TowerId { get; set; }
        public Nullable<bool> IsBlocked { get; set; }
    }
}
