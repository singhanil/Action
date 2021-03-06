USE [JewelOfIndia]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVisualDetail]    Script Date: 12/22/2014 11:29:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetVisualDetail]
	-- Add the parameters for the stored procedure here
	@Type NCHAR(10),
	@TypeId BIGINT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [Id]
      ,[Name]
      ,[DisplayName]
      ,[Type]
      ,[TypeId]
  FROM [dbo].[Visual]
  where Type=@Type AND TypeId=@TypeId
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetTowerDetail]    Script Date: 12/22/2014 11:29:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetTowerDetail]
	-- Add the parameters for the stored procedure here
	@Id bigint
	
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
  where Id = @Id

END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetApartmentDetail]    Script Date: 12/22/2014 11:29:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetApartmentDetail]
	-- Add the parameters for the stored procedure here
	@ID bigint
	
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
  where Id=@ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateApartmentSalesStatus]    Script Date: 12/22/2014 11:29:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdateApartmentSalesStatus]
	-- Add the parameters for the stored procedure here
	@ApartmentId BIGINT,
	@BlockedStartDate DATETIME,
	@BlockedEndDate DATETIME,
	@IsBlocked BIT,
	@UserId BIGINT
	
AS

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
	SET NOCOUNT ON;
	
    -- Insert statements for procedure here
	UPDATE dbo.ApartmetSales SET IsBlocked = @IsBlocked,BlockStartDate=@BlockedStartDate,
	BlockEndDate=@BlockedEndDate,UserId=@UserId
	WHERE ApartmentId = @ApartmentId
GO

CREATE PROCEDURE [dbo].[sp_GetApartmentSalesByUser]
	-- Add the parameters for the stored procedure here
	@UserId BIGINT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
SET NOCOUNT ON;
	DECLARE @IsAdmin BIT
	SELECT @IsAdmin = IsOwner FROM dbo.Users WHERE id =  @UserId
	IF @IsAdmin = 1
	BEGIN
		SELECT p.Description AS [PropertyDesc],T.TowerDirection AS [TowerDesc],A.Description AS [ApartmentDesc],CONVERT(VARCHAR(24),BlockStartDate,103) AS [StartDate] FROM dbo.Properties p WITH(NOLOCK) INNER JOIN dbo.Towers T ON	T.PropertyId = p.Id INNER JOIN dbo.Apartments A ON	A.TowerId = T.Id
		INNER JOIN dbo.ApartmetSales ON	ApartmetSales.ApartmentId = A.Id
		
	END
	ELSE
	BEGIN
		SELECT p.Description AS [PropertyDesc],T.TowerDirection AS [TowerDesc],A.Description AS [ApartmentDesc],CONVERT(VARCHAR(24),BlockStartDate,103) AS [StartDate]  FROM dbo.Properties p WITH(NOLOCK) INNER JOIN dbo.Towers T ON	T.PropertyId = p.Id INNER JOIN dbo.Apartments A ON	A.TowerId = T.Id
		INNER JOIN dbo.ApartmetSales ON	ApartmetSales.ApartmentId = A.Id
		WHERE UserId = @UserId
		
	END
END

GO
