//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System.ComponentModel.DataAnnotations;

namespace JewelOfIndiaBuilder.Models
{
    using System;
    
    public partial class sp_GetApartmentWithStatus_Result
    {
        public Nullable<int> BedRoom { get; set; }
        public Nullable<int> Bathroom { get; set; }
        public Nullable<int> Garage { get; set; }
        public string Description { get; set; }
        public Nullable<short> FloorLevel { get; set; }
        public Nullable<bool> IsBlocked { get; set; }
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}",
               ApplyFormatInEditMode = true)]
        public Nullable<System.DateTime> BlockStartDate { get; set; }
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}",
               ApplyFormatInEditMode = true)]
        public Nullable<System.DateTime> BlockEndDate { get; set; }
        public string SalesType { get; set; }
    }
}
