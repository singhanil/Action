USE [JewelofIndia]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 02/08/2015 17:32:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](100) NULL,
	[Password] [nvarchar](100) NULL,
	[Salt] [nvarchar](200) NULL,
	[Question] [nvarchar](100) NULL,
	[Answer] [nvarchar](100) NULL,
	[EmailId] [nvarchar](100) NULL,
	[IsOwner] [bit] NULL,
	[MobileNo] [nvarchar](50) NULL,
	[DOB] [datetime] NULL,
	[UserTypeId] [int] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UQ__Users__C9F2845606CD04F7] UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ApartmetSales]    Script Date: 02/08/2015 17:32:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApartmetSales](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ApartmentId] [bigint] NULL,
	[IsBlocked] [bit] NOT NULL,
	[CustomerId] [bigint] NULL,
	[UserId] [bigint] NULL,
	[BlockStartDate] [datetime] NULL,
	[SalesType] [smallint] NULL,
	[BlockEndDate] [datetime] NULL,
	[Customer Name] [nvarchar](500) NULL,
	[Broker Name] [nvarchar](500) NULL,
 CONSTRAINT [PK_ApartmetSales] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  ForeignKey [FK_ApartmetSales_Apartment]    Script Date: 02/08/2015 17:32:37 ******/
ALTER TABLE [dbo].[ApartmetSales]  WITH CHECK ADD  CONSTRAINT [FK_ApartmetSales_Apartment] FOREIGN KEY([ApartmentId])
REFERENCES [dbo].[Apartments] ([Id])
GO
ALTER TABLE [dbo].[ApartmetSales] CHECK CONSTRAINT [FK_ApartmetSales_Apartment]
GO
/****** Object:  ForeignKey [FK_ApartmetSales_ApartmentSalesType]    Script Date: 02/08/2015 17:32:37 ******/
ALTER TABLE [dbo].[ApartmetSales]  WITH CHECK ADD  CONSTRAINT [FK_ApartmetSales_ApartmentSalesType] FOREIGN KEY([SalesType])
REFERENCES [dbo].[ApartmentSalesType] ([Id])
GO
ALTER TABLE [dbo].[ApartmetSales] CHECK CONSTRAINT [FK_ApartmetSales_ApartmentSalesType]
GO
/****** Object:  ForeignKey [FK_ApartmetSales_Customer]    Script Date: 02/08/2015 17:32:37 ******/
ALTER TABLE [dbo].[ApartmetSales]  WITH CHECK ADD  CONSTRAINT [FK_ApartmetSales_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[ApartmetSales] CHECK CONSTRAINT [FK_ApartmetSales_Customer]
GO
/****** Object:  ForeignKey [FK_ApartmetSales_Users]    Script Date: 02/08/2015 17:32:37 ******/
ALTER TABLE [dbo].[ApartmetSales]  WITH CHECK ADD  CONSTRAINT [FK_ApartmetSales_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[ApartmetSales] CHECK CONSTRAINT [FK_ApartmetSales_Users]
GO
/****** Object:  ForeignKey [FK_Users_UserType]    Script Date: 02/08/2015 17:32:37 ******/
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_UserType] FOREIGN KEY([UserTypeId])
REFERENCES [dbo].[UserType] ([Id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_UserType]
GO
