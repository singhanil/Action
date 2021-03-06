USE [master]
GO
/****** Object:  Database [JewelOfIndia]    Script Date: 12/4/2014 11:41:59 AM ******/
CREATE DATABASE [JewelOfIndia] ON  PRIMARY 
( NAME = N'JewelOfIndia', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS\MSSQL\DATA\JewelOfIndia.mdf' , SIZE = 2048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'JewelOfIndia_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS\MSSQL\DATA\JewelOfIndia_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [JewelOfIndia] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [JewelOfIndia].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [JewelOfIndia] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [JewelOfIndia] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [JewelOfIndia] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [JewelOfIndia] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [JewelOfIndia] SET ARITHABORT OFF 
GO
ALTER DATABASE [JewelOfIndia] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [JewelOfIndia] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [JewelOfIndia] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [JewelOfIndia] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [JewelOfIndia] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [JewelOfIndia] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [JewelOfIndia] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [JewelOfIndia] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [JewelOfIndia] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [JewelOfIndia] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [JewelOfIndia] SET  DISABLE_BROKER 
GO
ALTER DATABASE [JewelOfIndia] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [JewelOfIndia] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [JewelOfIndia] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [JewelOfIndia] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [JewelOfIndia] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [JewelOfIndia] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [JewelOfIndia] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [JewelOfIndia] SET RECOVERY FULL 
GO
ALTER DATABASE [JewelOfIndia] SET  MULTI_USER 
GO
ALTER DATABASE [JewelOfIndia] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [JewelOfIndia] SET DB_CHAINING OFF 
GO
USE [JewelOfIndia]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetApartmentFeature]    Script Date: 12/4/2014 11:42:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetApartmentFeature]
	-- Add the parameters for the stored procedure here
	@ApartmentId BIGINT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT f.Id,FT.Code,F.Name,F.Description FROM dbo.Features F WITH(NOLOCK) 
	INNER JOIN dbo.ApartmentFeature [AF] WITH(NOLOCK) ON	[AF].Features_Id = F.Id
	INNER JOIN dbo.FeatureTypes [FT] ON	FT.Id = F.FeatureTypeId
	WHERE AF.Apartments_Id=@ApartmentId

END



GO
/****** Object:  StoredProcedure [dbo].[sp_GetApartments]    Script Date: 12/4/2014 11:42:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetApartments]
	-- Add the parameters for the stored procedure here
	@TowerId bigint
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [Id]
      ,[BedRoom]
      ,[Bathroom]
      ,[Garage]
      ,[Description]
      ,[FloorLevel]
      ,[Direction]
      ,[TowerId]
  FROM [dbo].[Apartments]
  where TowerId=@TowerId
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetProperties]    Script Date: 12/4/2014 11:42:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetProperties]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT A.[Id]
      ,[Feature]
      ,[Description]
      ,B.Address + ' - ' + B.state + ' - ' + B.Country as Location 
      ,C.CodeReference
  FROM [dbo].[Properties] A, dbo.Locations B, dbo.PropertyTypes C
  where A.LocationId = B.Id
	and A.PropertyTypeId = C.Id
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetPropertyFeature]    Script Date: 12/4/2014 11:42:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetPropertyFeature]
	-- Add the parameters for the stored procedure here
	@PropertyId BIGINT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT f.Id,FT.Code,F.Name,f.Description FROM dbo.Features F WITH(NOLOCK) 
	INNER JOIN dbo.PropertyFeature [PF] WITH(NOLOCK) ON	[PF].Features_Id = F.Id
	INNER JOIN dbo.FeatureTypes [FT] ON	FT.Id = F.FeatureTypeId
	WHERE PF.Properties_Id=@PropertyId
	
END



GO
/****** Object:  StoredProcedure [dbo].[sp_GetTower]    Script Date: 12/4/2014 11:42:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetTower]
	-- Add the parameters for the stored procedure here
	@PropertyId bigint
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [Id]
      ,[PropertyId]
      ,[TowerName]
      ,[TowerDirection]
      ,[Description]
  FROM [dbo].[Towers]
  where PropertyId = @PropertyId

END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetTowerFeature]    Script Date: 12/4/2014 11:42:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetTowerFeature]
	-- Add the parameters for the stored procedure here
	@TowerId BIGINT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT f.Id,FT.Code,F.Name,F.Description FROM dbo.Feature F WITH(NOLOCK) 
	INNER JOIN dbo.TowerFeature [TF] WITH(NOLOCK) ON	[TF].FeatureId = F.Id
	INNER JOIN dbo.FeatureType [FT] ON	FT.Id = F.FeatureTypeId
	WHERE TF.TowerId=@TowerId

END



GO
/****** Object:  StoredProcedure [dbo].[sp_GetUser]    Script Date: 12/4/2014 11:42:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetUser]
	-- Add the parameters for the stored procedure here
	@UserName NVARCHAR(100),
	@Password NVARCHAR(100)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [Id]
      ,[UserName]
      ,[Password]
      ,[EmailId]
      ,[IsOwner]
      ,[MobileNo]
      ,[DOB]
  FROM [dbo].[Users]
  where UserName = @UserName
  AND Password=@Password

END





GO
/****** Object:  Table [dbo].[ApartmentFeature]    Script Date: 12/4/2014 11:42:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApartmentFeature](
	[Apartments_Id] [bigint] NOT NULL,
	[Features_Id] [bigint] NOT NULL,
 CONSTRAINT [PK_ApartmentFeature] PRIMARY KEY NONCLUSTERED 
(
	[Apartments_Id] ASC,
	[Features_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Apartments]    Script Date: 12/4/2014 11:42:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Apartments](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[BedRoom] [int] NULL,
	[Bathroom] [int] NULL,
	[Garage] [int] NULL,
	[Description] [nvarchar](1000) NULL,
	[FloorLevel] [smallint] NULL,
	[Direction] [varchar](max) NOT NULL,
	[TowerId] [bigint] NULL,
 CONSTRAINT [PK_Apartments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ApartmetSales]    Script Date: 12/4/2014 11:42:00 AM ******/
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
	[BlockEndDate] [datetime] NULL,
 CONSTRAINT [PK_ApartmetSales] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customers]    Script Date: 12/4/2014 11:42:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Address] [nvarchar](200) NULL,
	[PhoneNo] [nvarchar](50) NULL,
	[EmailId] [nvarchar](100) NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Features]    Script Date: 12/4/2014 11:42:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Features](
	[Id] [bigint] NOT NULL,
	[FeatureTypeId] [int] NOT NULL,
	[Name] [varchar](max) NOT NULL,
	[Description] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Features] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FeatureTypes]    Script Date: 12/4/2014 11:42:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FeatureTypes](
	[Id] [int] NOT NULL,
	[Code] [varchar](50) NOT NULL,
	[Name] [varchar](max) NOT NULL,
	[Description] [varchar](max) NOT NULL,
 CONSTRAINT [PK_FeatureTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Locations]    Script Date: 12/4/2014 11:42:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Locations](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Address] [nvarchar](50) NULL,
	[ZipCode] [nvarchar](50) NULL,
	[state] [nvarchar](50) NULL,
	[Country] [nvarchar](50) NULL,
	[Latitude] [nchar](10) NULL,
	[Longitude] [nchar](10) NULL,
 CONSTRAINT [PK_Locations] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Properties]    Script Date: 12/4/2014 11:42:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Properties](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Feature] [nvarchar](200) NULL,
	[Description] [nvarchar](500) NULL,
	[LocationId] [int] NULL,
	[PropertyTypeId] [int] NULL,
 CONSTRAINT [PK_Properties] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PropertyFeature]    Script Date: 12/4/2014 11:42:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PropertyFeature](
	[Features_Id] [bigint] NOT NULL,
	[Properties_Id] [bigint] NOT NULL,
 CONSTRAINT [PK_PropertyFeature] PRIMARY KEY NONCLUSTERED 
(
	[Features_Id] ASC,
	[Properties_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PropertyTypes]    Script Date: 12/4/2014 11:42:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PropertyTypes](
	[Id] [int] NOT NULL,
	[CodeReference] [nchar](10) NULL,
 CONSTRAINT [PK_PropertyTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TowerFeature]    Script Date: 12/4/2014 11:42:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TowerFeature](
	[Features_Id] [bigint] NOT NULL,
	[Towers_Id] [bigint] NOT NULL,
 CONSTRAINT [PK_TowerFeature] PRIMARY KEY NONCLUSTERED 
(
	[Features_Id] ASC,
	[Towers_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Towers]    Script Date: 12/4/2014 11:42:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Towers](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[PropertyId] [bigint] NOT NULL,
	[TowerName] [nvarchar](100) NULL,
	[TowerDirection] [nvarchar](100) NULL,
	[Description] [nvarchar](500) NULL,
 CONSTRAINT [PK_Towers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 12/4/2014 11:42:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](100) NULL,
	[Password] [nvarchar](100) NULL,
	[EmailId] [nvarchar](100) NULL,
	[IsOwner] [bit] NULL,
	[MobileNo] [nvarchar](50) NULL,
	[DOB] [datetime] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Visual]    Script Date: 12/4/2014 11:42:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Visual](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[DisplayName] [nvarchar](50) NOT NULL,
	[Type] [nchar](10) NOT NULL,
	[TypeId] [bigint] NOT NULL,
 CONSTRAINT [PK_Visual] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Index [IX_FK_ApartmentFeature_Feature]    Script Date: 12/4/2014 11:42:00 AM ******/
CREATE NONCLUSTERED INDEX [IX_FK_ApartmentFeature_Feature] ON [dbo].[ApartmentFeature]
(
	[Features_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FK_Apartment_Tower]    Script Date: 12/4/2014 11:42:00 AM ******/
CREATE NONCLUSTERED INDEX [IX_FK_Apartment_Tower] ON [dbo].[Apartments]
(
	[TowerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FK_ApartmetSales_Apartment]    Script Date: 12/4/2014 11:42:00 AM ******/
CREATE NONCLUSTERED INDEX [IX_FK_ApartmetSales_Apartment] ON [dbo].[ApartmetSales]
(
	[ApartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FK_ApartmetSales_Customer]    Script Date: 12/4/2014 11:42:00 AM ******/
CREATE NONCLUSTERED INDEX [IX_FK_ApartmetSales_Customer] ON [dbo].[ApartmetSales]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FK_ApartmetSales_User]    Script Date: 12/4/2014 11:42:00 AM ******/
CREATE NONCLUSTERED INDEX [IX_FK_ApartmetSales_User] ON [dbo].[ApartmetSales]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FK_Feature_FeatureType]    Script Date: 12/4/2014 11:42:00 AM ******/
CREATE NONCLUSTERED INDEX [IX_FK_Feature_FeatureType] ON [dbo].[Features]
(
	[FeatureTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FK_Property_Location]    Script Date: 12/4/2014 11:42:00 AM ******/
CREATE NONCLUSTERED INDEX [IX_FK_Property_Location] ON [dbo].[Properties]
(
	[LocationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FK_Property_PropertyType]    Script Date: 12/4/2014 11:42:00 AM ******/
CREATE NONCLUSTERED INDEX [IX_FK_Property_PropertyType] ON [dbo].[Properties]
(
	[PropertyTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FK_PropertyFeature_Property]    Script Date: 12/4/2014 11:42:00 AM ******/
CREATE NONCLUSTERED INDEX [IX_FK_PropertyFeature_Property] ON [dbo].[PropertyFeature]
(
	[Properties_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FK_TowerFeature_Tower]    Script Date: 12/4/2014 11:42:00 AM ******/
CREATE NONCLUSTERED INDEX [IX_FK_TowerFeature_Tower] ON [dbo].[TowerFeature]
(
	[Towers_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FK_Tower_Property]    Script Date: 12/4/2014 11:42:00 AM ******/
CREATE NONCLUSTERED INDEX [IX_FK_Tower_Property] ON [dbo].[Towers]
(
	[PropertyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ApartmentFeature]  WITH CHECK ADD  CONSTRAINT [FK_ApartmentFeature_Apartment] FOREIGN KEY([Apartments_Id])
REFERENCES [dbo].[Apartments] ([Id])
GO
ALTER TABLE [dbo].[ApartmentFeature] CHECK CONSTRAINT [FK_ApartmentFeature_Apartment]
GO
ALTER TABLE [dbo].[ApartmentFeature]  WITH CHECK ADD  CONSTRAINT [FK_ApartmentFeature_Feature] FOREIGN KEY([Features_Id])
REFERENCES [dbo].[Features] ([Id])
GO
ALTER TABLE [dbo].[ApartmentFeature] CHECK CONSTRAINT [FK_ApartmentFeature_Feature]
GO
ALTER TABLE [dbo].[Apartments]  WITH CHECK ADD  CONSTRAINT [FK_Apartment_Tower] FOREIGN KEY([TowerId])
REFERENCES [dbo].[Towers] ([Id])
GO
ALTER TABLE [dbo].[Apartments] CHECK CONSTRAINT [FK_Apartment_Tower]
GO
ALTER TABLE [dbo].[ApartmetSales]  WITH CHECK ADD  CONSTRAINT [FK_ApartmetSales_Apartment] FOREIGN KEY([ApartmentId])
REFERENCES [dbo].[Apartments] ([Id])
GO
ALTER TABLE [dbo].[ApartmetSales] CHECK CONSTRAINT [FK_ApartmetSales_Apartment]
GO
ALTER TABLE [dbo].[ApartmetSales]  WITH CHECK ADD  CONSTRAINT [FK_ApartmetSales_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[ApartmetSales] CHECK CONSTRAINT [FK_ApartmetSales_Customer]
GO
ALTER TABLE [dbo].[ApartmetSales]  WITH CHECK ADD  CONSTRAINT [FK_ApartmetSales_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[ApartmetSales] CHECK CONSTRAINT [FK_ApartmetSales_User]
GO
ALTER TABLE [dbo].[Features]  WITH CHECK ADD  CONSTRAINT [FK_Feature_FeatureType] FOREIGN KEY([FeatureTypeId])
REFERENCES [dbo].[FeatureTypes] ([Id])
GO
ALTER TABLE [dbo].[Features] CHECK CONSTRAINT [FK_Feature_FeatureType]
GO
ALTER TABLE [dbo].[Properties]  WITH CHECK ADD  CONSTRAINT [FK_Property_Location] FOREIGN KEY([LocationId])
REFERENCES [dbo].[Locations] ([Id])
GO
ALTER TABLE [dbo].[Properties] CHECK CONSTRAINT [FK_Property_Location]
GO
ALTER TABLE [dbo].[Properties]  WITH CHECK ADD  CONSTRAINT [FK_Property_PropertyType] FOREIGN KEY([PropertyTypeId])
REFERENCES [dbo].[PropertyTypes] ([Id])
GO
ALTER TABLE [dbo].[Properties] CHECK CONSTRAINT [FK_Property_PropertyType]
GO
ALTER TABLE [dbo].[PropertyFeature]  WITH CHECK ADD  CONSTRAINT [FK_PropertyFeature_Feature] FOREIGN KEY([Features_Id])
REFERENCES [dbo].[Features] ([Id])
GO
ALTER TABLE [dbo].[PropertyFeature] CHECK CONSTRAINT [FK_PropertyFeature_Feature]
GO
ALTER TABLE [dbo].[PropertyFeature]  WITH CHECK ADD  CONSTRAINT [FK_PropertyFeature_Property] FOREIGN KEY([Properties_Id])
REFERENCES [dbo].[Properties] ([Id])
GO
ALTER TABLE [dbo].[PropertyFeature] CHECK CONSTRAINT [FK_PropertyFeature_Property]
GO
ALTER TABLE [dbo].[TowerFeature]  WITH CHECK ADD  CONSTRAINT [FK_TowerFeature_Feature] FOREIGN KEY([Features_Id])
REFERENCES [dbo].[Features] ([Id])
GO
ALTER TABLE [dbo].[TowerFeature] CHECK CONSTRAINT [FK_TowerFeature_Feature]
GO
ALTER TABLE [dbo].[TowerFeature]  WITH CHECK ADD  CONSTRAINT [FK_TowerFeature_Tower] FOREIGN KEY([Towers_Id])
REFERENCES [dbo].[Towers] ([Id])
GO
ALTER TABLE [dbo].[TowerFeature] CHECK CONSTRAINT [FK_TowerFeature_Tower]
GO
ALTER TABLE [dbo].[Towers]  WITH CHECK ADD  CONSTRAINT [FK_Tower_Property] FOREIGN KEY([PropertyId])
REFERENCES [dbo].[Properties] ([Id])
GO
ALTER TABLE [dbo].[Towers] CHECK CONSTRAINT [FK_Tower_Property]
GO
USE [master]
GO
ALTER DATABASE [JewelOfIndia] SET  READ_WRITE 
GO
