USE [BD_IntraFirst]
GO
/****** Object:  StoredProcedure [dbo].[spBuscarEmpleado]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- ====================================================================================================
-- Author:		<Ligia Puertas>
-- Create date: <06-09-2012>
-- Description:	<Inclusion de Datos Tabla Areas>
-- =====================================================================================================
CREATE PROCEDURE [dbo].[spBuscarEmpleado]
	@TipoID VARCHAR(1),
	@IDNumero VARCHAR(12)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT *
	FROM Empleados 
	WHERE Empleados.TipoID = @TipoID AND Empleados.IDNumero = @IDNumero;
END

GO
/****** Object:  StoredProcedure [dbo].[spBuscarEmpleadosMostrarEnGaleria]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spBuscarEmpleadosMostrarEnGaleria]
AS
BEGIN
	SELECT 
		IDEmpleado, 
		TipoID, 
		IDNumero, 
		Nombre, 
		Apellido, 
		Sexo, 
		FechaNacimiento,
		NumSeguroSocial, 
		ImgFoto, 
		NombreFoto, 
		ImgFotoLong, 
		PinBB, 
		StatusPubDatos, 
		CodTipoEmpleado,
		CASE CodAreaTlfOficina
		WHEN 0 THEN ''
		ELSE CodAreaTlfOficina 
		END
		AS CodAreaTlfOficina,
		CASE NumTlfOficina
		WHEN 0 THEN ''
		ELSE NumTlfOficina 
		END 
		AS NumTlfOficina,
		CASE CodAreaTlfMovil
		WHEN 0 THEN ''
		ELSE CodAreaTlfMovil 
		END 
		AS CodAreaTlfMovil,
		CASE NumTlfMovil
		WHEN 0 THEN ''
		ELSE NumTlfMovil 
		END 
		AS NumTlfMovil,
		DescCargo, 
		FecIngreso, 
		Status
	FROM Empleados
	WHERE StatusPubDatos = '1'
	AND ImgFoto IS NOT NULL
	ORDER BY Apellido, Nombre ASC
END





GO
/****** Object:  StoredProcedure [dbo].[spBuscarImagen]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- ====================================================================================================
-- Author:		<Ligia Puertas>
-- Create date: <06-09-2012>
-- Description:	<Inclusion de Datos Tabla Areas>
-- =====================================================================================================
CREATE PROCEDURE [dbo].[spBuscarImagen]
	@IDEmpleado INT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT ImgFoto
	FROM Empleados 
	WHERE Empleados.IDEmpleado = @IDEmpleado;
END
GO
/****** Object:  StoredProcedure [dbo].[spBuscarNPost]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ====================================================================================================
-- Author:		<Ligia Puertas>
-- Create date: <06-09-2012>
-- Description:	<Buscar N cantidad de registros en la base de datos Post>
-- =====================================================================================================
CREATE PROCEDURE [dbo].[spBuscarNPost]
@NumReg INT
AS
BEGIN
	BEGIN
		SELECT TOP (@NumReg) Post.*, Categoria.nombre
		FROM Post
		INNER JOIN PostCategoria 
		ON Post.PostID = PostCategoria.PostID 
		INNER JOIN Categoria 
		ON PostCategoria.CategoriaID = Categoria.CategoriaID 
		ORDER BY Fecha DESC	
	END
END
















GO
/****** Object:  StoredProcedure [dbo].[spBuscarPopUpRandom]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ====================================================================================================
-- Author:		<Ligia Puertas>
-- Create date: <06-09-2012>
-- Description:	<Inclusion de Datos Tabla Empleados>
-- =====================================================================================================
CREATE PROCEDURE [dbo].[spBuscarPopUpRandom]
AS
BEGIN
	BEGIN
		SELECT TOP 1 *,
			CASE Status
				WHEN '1' THEN 'ACTIVO'
				ELSE 'INACTIVO'
			END AS StatusDesc
		FROM PopUp
		WHERE (Status = '1') AND (GETDATE() BETWEEN FechaDesde AND FechaHasta)
		ORDER BY NEWID()
	END
END













GO
/****** Object:  StoredProcedure [dbo].[spBuscarPopUpTodos]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- ====================================================================================================
-- Author:		<Ligia Puertas>
-- Create date: <06-09-2012>
-- Description:	<Inclusion de Datos Tabla Empleados>
-- =====================================================================================================
CREATE PROCEDURE [dbo].[spBuscarPopUpTodos]
AS
BEGIN
	BEGIN
		SELECT 
			IDPopUp,
			Titulo,
			Contenido,
			FechaDesde,
			FechaHasta,
			Status,
			CASE Status
				WHEN '1' THEN 'ACTIVO'
				ELSE 'INACTIVO'
			END AS StatusDesc,
			Enlace
		FROM PopUp
	END
END















GO
/****** Object:  StoredProcedure [dbo].[spBuscarPopUpTodosAC]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- ====================================================================================================
-- Author:		<Ligia Puertas>
-- Create date: <06-09-2012>
-- Description:	<Inclusion de Datos Tabla Empleados>
-- =====================================================================================================
CREATE PROCEDURE [dbo].[spBuscarPopUpTodosAC]
AS
BEGIN
	BEGIN
		SELECT 
			IDPopUp,
			Titulo,
			Contenido,
			FechaDesde,
			FechaHasta,
			Status,
			CASE Status
				WHEN '1' THEN 'ACTIVO'
				ELSE 'INACTIVO'
			END AS StatusDesc,
			Enlace
		FROM PopUp
		WHERE (Status = '1')
	END
END















GO
/****** Object:  StoredProcedure [dbo].[spBuscarPopUpTodosAutoComplete]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- ====================================================================================================
-- Author:		<Ligia Puertas>
-- Create date: <06-09-2012>
-- Description:	<Inclusion de Datos Tabla Empleados>
-- =====================================================================================================
CREATE PROCEDURE [dbo].[spBuscarPopUpTodosAutoComplete]
@Titulo varchar(500)
AS
BEGIN
	BEGIN
		SELECT 
			Titulo AS CampoAutoComplete
		FROM PopUp
		WHERE Titulo like @Titulo
	END
END
















GO
/****** Object:  StoredProcedure [dbo].[spBuscarPopUpTodosEnOrden]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ====================================================================================================
-- Author:		<Ligia Puertas>
-- Create date: <06-09-2012>
-- Description:	<Inclusion de Datos Tabla Empleados>
-- =====================================================================================================
CREATE PROCEDURE [dbo].[spBuscarPopUpTodosEnOrden]
@Orden varchar(4)
AS
BEGIN
	BEGIN
		SELECT 
			IDPopUp,
			Titulo,
			Contenido,
			FechaDesde,
			FechaHasta,
			Status,
			CASE Status
				WHEN '1' THEN 'ACTIVO'
				ELSE 'INACTIVO'
			END AS StatusDesc,
			Enlace
		FROM PopUp
		WHERE (Status = '1') AND (GETDATE() BETWEEN FechaDesde AND FechaHasta)
		ORDER BY 
			CASE @Orden
				WHEN 'ASC' THEN Titulo
				ELSE '1'
			END ASC,
			CASE @Orden
				WHEN 'DESC' THEN Titulo
				ELSE '1'
			END DESC
	END
END












GO
/****** Object:  StoredProcedure [dbo].[spBuscarPopUpTodosOrdenadoPor]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ====================================================================================================
-- Author:		<Ligia Puertas>
-- Create date: <06-09-2012>
-- Description:	<Inclusion de Datos Tabla Empleados>
-- =====================================================================================================
CREATE PROCEDURE [dbo].[spBuscarPopUpTodosOrdenadoPor]
@CampoOrden varchar(30),
@Orden varchar(4)
AS
BEGIN
	BEGIN
		SELECT 
			IDPopUp,
			Titulo,
			Contenido,
			FechaDesde,
			FechaHasta,
			Status,
			CASE Status
				WHEN '1' THEN 'ACTIVO'
				ELSE 'INACTIVO'
			END AS StatusDesc,
			Enlace
		FROM PopUp
		WHERE (Status = '1') AND (GETDATE() BETWEEN FechaDesde AND FechaHasta)
		ORDER BY 
			CASE @Orden
				WHEN 'ASC' THEN 
					CASE @CampoOrden
						WHEN 'Titulo' THEN Titulo
						WHEN 'FechaDesde' THEN FechaDesde
						WHEN 'FechaHasta' THEN FechaHasta
						WHEN 'Status' THEN Status
						ELSE IDPopUp
					END
				ELSE '1'
				END ASC,
			CASE @Orden
				WHEN 'DESC' THEN
						CASE @CampoOrden
							WHEN 'Titulo' THEN Titulo
							WHEN 'FechaDesde' THEN FechaDesde
							WHEN 'FechaHasta' THEN FechaHasta
							WHEN 'Status' THEN Status
							ELSE IDPopUp
						END
					ELSE '1'
				END DESC
	END
END












GO
/****** Object:  StoredProcedure [dbo].[spBuscarPopUpxID]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- ====================================================================================================
-- Author:		<Ligia Puertas>
-- Create date: <06-09-2012>
-- Description:	<Inclusion de Datos Tabla Empleados>
-- =====================================================================================================
CREATE PROCEDURE [dbo].[spBuscarPopUpxID]
@IDPopUp INT
AS
BEGIN
	BEGIN
		SELECT 
			IDPopUp,
			Titulo,
			Contenido,
			FechaDesde,
			FechaHasta,
			ImgFondo,
			NombreImagenFondo,
			ImgFondoLong,
			Status,
			CASE Status
				WHEN '1' THEN 'ACTIVO'
				ELSE 'INACTIVO'
			END AS StatusDesc,
			Enlace
		FROM PopUp
		WHERE (IDPopUp = @IDPopUp)
	END
END















GO
/****** Object:  StoredProcedure [dbo].[spBuscarProximosAniversarios]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ====================================================================================================
-- Author:		<Ligia Puertas>
-- Create date: <06-09-2012>
-- Description:	<Devuelve las fechas de>
-- =====================================================================================================
CREATE PROCEDURE [dbo].[spBuscarProximosAniversarios]
AS
BEGIN
SELECT *,
	CASE 
		WHEN  FechaAniversario >= GETDATE() THEN FechaAniversario
		ELSE DATEADD(YEAR,1,FechaAniversario)
	END AS FechaProximoAniversario
	FROM VT_ProximosAniversarios
	ORDER BY FechaProximoAniversario ASC
END



GO
/****** Object:  StoredProcedure [dbo].[spBuscarProximosCumpleanios]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ====================================================================================================
-- Author:		<Ligia Puertas>
-- Create date: <06-09-2012>
-- Description:	<Devuelve las fechas de>
-- =====================================================================================================
CREATE PROCEDURE [dbo].[spBuscarProximosCumpleanios]
AS
BEGIN
	SELECT *,
	CASE 
		WHEN  FechaCumpleanio >= GETDATE() THEN FechaCumpleanio
		ELSE DATEADD(YEAR,1,FechaCumpleanio)
	END AS FechaProximoCumpleanios
	FROM VT_ProximosCumpleanos
	ORDER BY FechaProximoCumpleanios ASC
END





GO
/****** Object:  StoredProcedure [dbo].[spBuscarURLFeedsTodos]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- ====================================================================================================
-- Author:		<Ligia Puertas>
-- Create date: <06-09-2012>
-- Description:	<Inclusion de Datos Tabla Empleados>
-- =====================================================================================================
CREATE PROCEDURE [dbo].[spBuscarURLFeedsTodos]
AS
BEGIN
	BEGIN
		SELECT * FROM URLFeeds	
		ORDER BY Propietario DESC, IDURLFeed ASC
	END
END


















GO
/****** Object:  StoredProcedure [dbo].[spBuscarUsuarios]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ====================================================================================================
-- Author:		<Ligia Puertas>
-- Create date: <06-09-2012>
-- Description:	<Inclusion de Datos Tabla Empleados>
-- =====================================================================================================
CREATE PROCEDURE [dbo].[spBuscarUsuarios]
	@Usuario varchar(50)
AS
BEGIN
	DECLARE @FechaHoraActual DATETIME
	SELECT *
	FROM Usuario
	WHERE (Usuario = @Usuario)
	SET @FechaHoraActual = getdate();
	UPDATE Usuario SET FechaUltimaConexion = @FechaHoraActual
	WHERE (Usuario = @Usuario)
END











GO
/****** Object:  StoredProcedure [dbo].[spBuscarUsuarioxID]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ====================================================================================================
-- Author:		<Ligia Puertas>
-- Create date: <06-09-2012>
-- Description:	<Inclusion de Datos Tabla Empleados>
-- =====================================================================================================
CREATE PROCEDURE [dbo].[spBuscarUsuarioxID]
@IDUsuario INT
AS
BEGIN
	BEGIN
		SELECT 
			IDUsuario,
			Usuario,
			Clave,	
			Status,
			StatusBloqueo,
			IntentosFallidos,
			FechaUltimaConexion
		FROM Usuarios
		WHERE (IDUsuario = @IDUsuario)
	END
END
















GO
/****** Object:  StoredProcedure [dbo].[spBuscarUsuarioxNombre]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ====================================================================================================
-- Author:		<Ligia Puertas>
-- Create date: <06-09-2012>
-- Description:	<Inclusion de Datos Tabla Empleados>
-- =====================================================================================================
CREATE PROCEDURE [dbo].[spBuscarUsuarioxNombre]
	@Usuario varchar(50)
AS
BEGIN
	DECLARE @FechaHoraActual DATETIME
	SELECT *
	FROM Usuario
	WHERE (Usuario = @Usuario)
	SET @FechaHoraActual = getdate();
	UPDATE Usuario SET FechaUltimaConexion = @FechaHoraActual
	WHERE (Usuario = @Usuario)
END












GO
/****** Object:  StoredProcedure [dbo].[spDivisionGeograficaBuscarID]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ====================================================================================================
-- Author:		<Ligia Puertas>
-- Create date: <06-09-2012>
-- Description:	<Obtener Division Geográfica por ID>
-- =====================================================================================================
CREATE PROCEDURE [dbo].[spDivisionGeograficaBuscarID]
@PK_MSTDivisionGeografica INT
AS
BEGIN
	BEGIN
		SELECT *
		FROM MSTDivisionGeografica
		WHERE (PK_MSTDivisionGeografica = @PK_MSTDivisionGeografica)
	END
END
















GO
/****** Object:  StoredProcedure [dbo].[spEliminarPopUp]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spEliminarPopUp]
@IDPopUp int,
@Titulo	varchar(500),
@Contenido	varchar(6000),
@FechaDesde	smalldatetime,
@FechaHasta	smalldatetime,
@ImgFondo image,
@NombreImagenFondo varchar(300),
@ImgFondoLong int,
@Status	char(1),
@TotalFilas int OUTPUT
AS
BEGIN
	BEGIN
		DELETE FROM PopUp
		WHERE IDPopUp = @IDPopUp 
		SELECT @TotalFilas = @@ROWCOUNT;
	END
END




GO
/****** Object:  StoredProcedure [dbo].[spEliminarURLFeed]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--  = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
-- Author:		<Ligia Puertas>
-- Create date: <06-09-2012>
-- Description:	<Inclusion de Datos Tabla Empleados>
-- Error Values: 
--		-1: Área No existe
--		-2: Área existe
--  = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
CREATE PROCEDURE [dbo].[spEliminarURLFeed]
@IDURLFeed int,
@TotalFilas int OUTPUT
AS
BEGIN
	BEGIN
		DELETE  
		FROM dbo.URLFeeds 
		WHERE IDURLFeed = @IDURLFeed;
		SELECT @TotalFilas = @@ROWCOUNT;
	END
END












GO
/****** Object:  StoredProcedure [dbo].[spImagenEmpleado]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ====================================================================================================
-- Author:		<Ligia Puertas>
-- Create date: <06-09-2012>
-- Description:	<Devuelve Lista de Empleados a Mostrar en la Galeria>
-- =====================================================================================================
CREATE PROCEDURE [dbo].[spImagenEmpleado]
@IDEmpleado int
AS
BEGIN
	SELECT ImgFoto
	FROM Empleados
	WHERE IDEmpleado=@IDEmpleado
	ORDER BY Apellido, Nombre ASC
END




GO
/****** Object:  StoredProcedure [dbo].[spImagenNoticia]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spImagenNoticia]
@IDNoticia int
AS
BEGIN
	SELECT ImgFondo
	FROM Post
	WHERE PostID=@IDNoticia
END





GO
/****** Object:  StoredProcedure [dbo].[spIncluirEmpleados]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spIncluirEmpleados]
	@IDEmpleado int OUTPUT,
	@TipoID varchar(1),
	@IDNumero varchar(12),
	@Nombre varchar(50),
	@Apellido varchar(50),
	@Sexo char(1),
	@FechaNacimiento smalldatetime,
	@NumSeguroSocial varchar(10),
	@ImgFoto image,
	@NombreFoto varchar(300),
	@ImgFotoLong int,
	@StatusPubDatos char(1),
	@CodTipoEmpleado char(2),
	@CodAreaTlfOficina varchar(4),
	@NumTlfOficina varchar(10),
	@CodAreaTlfMovil varchar(4),
	@NumTlfMovil varchar(10),
	@DescCargo varchar(300),
	@FecIngreso smalldatetime,
	@Status	char(1)
AS
BEGIN
	IF NOT EXISTS(SELECT @IDEmpleado FROM Empleados WHERE TipoID=@TipoID AND IDNumero = @IDNumero) 
	BEGIN
		SET NOCOUNT OFF;
		INSERT INTO Empleados (TipoID, IDNumero, Nombre, Apellido, Sexo, FechaNacimiento, NumSeguroSocial, ImgFoto, NombreFoto, ImgFotoLong, StatusPubDatos, CodTipoEmpleado, CodAreaTlfOficina, NumTlfOficina, CodAreaTlfMovil, NumTlfMovil, DescCargo, FecIngreso, Status) 
		VALUES(@TipoID, @IDNumero, @Nombre, @Apellido, @Sexo, @FechaNacimiento, @NumSeguroSocial, @ImgFoto, @NombreFoto, @ImgFotoLong, @StatusPubDatos, @CodTipoEmpleado, @CodAreaTlfOficina, @NumTlfOficina, @CodAreaTlfMovil, @NumTlfMovil, @DescCargo, @FecIngreso, @Status);
        SET @IDEmpleado = SCOPE_IDENTITY();
		SET NOCOUNT ON;
	END
END








GO
/****** Object:  StoredProcedure [dbo].[spIncluirPopUp]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ====================================================================================================
-- Author:		<Ligia Puertas>
-- Create date: <06-09-2012>
-- Description:	<Inclusion de Datos Tabla Empleados>
-- Error Values: 
--		-1: Área No existe
--		-2: Área existe
-- =====================================================================================================
CREATE PROCEDURE [dbo].[spIncluirPopUp]
@IDPopUp int,
@Titulo	varchar(500),
@Contenido	varchar(6000),
@FechaDesde	smalldatetime,
@FechaHasta	smalldatetime,
@ImgFondo image,
@NombreImagenFondo varchar(300),
@ImgFondoLong int,
@Status	char(1)
AS
BEGIN
	BEGIN
		SET NOCOUNT OFF;
		INSERT INTO PopUp (Titulo, Contenido,FechaDesde,FechaHasta, ImgFondo, NombreImagenFondo, ImgFondoLong ,Status) 
		VALUES(@Titulo, @Contenido,@FechaDesde,@FechaHasta, @ImgFondo, @NombreImagenFondo, @ImgFondoLong ,@Status);
		SET @IDPopUp = SCOPE_IDENTITY();
		SET NOCOUNT ON;
	END
END











GO
/****** Object:  StoredProcedure [dbo].[spIncluirUsuario]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- ====================================================================================================
-- Author:		<Ligia Puertas>
-- Create date: <06-09-2012>
-- Description:	<Inclusion de Datos Tabla Empleados>
-- Error Values: 
--		-1: Área No existe
--		-2: Área existe
-- =====================================================================================================
CREATE PROCEDURE [dbo].[spIncluirUsuario]
@Usuario varchar(50),
@Nombre	varchar(100),
@Clave varchar(100),
@Status	char(1),
@StatusBloqueo char(1),
@IDUsuario int OUTPUT
AS
BEGIN
	IF NOT EXISTS(SELECT IDUsuario FROM Usuario WHERE Usuario = @Usuario) 
	BEGIN
		SET NOCOUNT OFF;
		INSERT INTO Usuario (Usuario, Nombre, Clave, Status, StatusBloqueo)
		VALUES(@Usuario, @Nombre, @Clave, @Status, @StatusBloqueo);
		SELECT @IDUsuario = @@IDENTITY;
		SET NOCOUNT ON;
	END
END












GO
/****** Object:  StoredProcedure [dbo].[spModificarEmpleados]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spModificarEmpleados]
	@IDEmpleado int,
	@TipoID varchar(1),
	@IDNumero varchar(12),
	@Nombre varchar(50),
	@Apellido varchar(50),
	@Sexo char(1),
	@FechaNacimiento smalldatetime,
	@NumSeguroSocial varchar(10),
	@ImgFoto image,
	@NombreFoto varchar(300),
	@ImgFotoLong int,
	@StatusPubDatos char(1),
	@CodTipoEmpleado char(2),
	@CodAreaTlfOficina varchar(4),
	@NumTlfOficina varchar(10),
	@CodAreaTlfMovil varchar(4),
	@NumTlfMovil varchar(10),
	@DescCargo varchar(300),
	@FecIngreso smalldatetime,
	@Status	char(1),
	@TotalFilas int OUTPUT
AS
BEGIN
	BEGIN
		UPDATE Empleados
		SET TipoID = @TipoID, IDNumero = @IDNumero, Nombre = @Nombre, Apellido = @Apellido, Sexo = @Sexo, FechaNacimiento = @FechaNacimiento, NumSeguroSocial = @NumSeguroSocial, ImgFoto = @ImgFoto, NombreFoto = @NombreFoto, ImgFotoLong = @ImgFotoLong, StatusPubDatos = @StatusPubDatos, CodTipoEmpleado = @CodTipoEmpleado, CodAreaTlfOficina = @CodAreaTlfOficina, NumTlfOficina = @NumTlfOficina, CodAreaTlfMovil = @CodAreaTlfMovil, NumTlfMovil = @NumTlfMovil, DescCargo = @DescCargo, FecIngreso = @FecIngreso, Status = @Status  
		WHERE IDEmpleado = @IDEmpleado
		SELECT @TotalFilas = @@ROWCOUNT;
	END
END









GO
/****** Object:  StoredProcedure [dbo].[spModificarPopUp]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- ====================================================================================================
-- Author:		<Ligia Puertas>
-- Create date: <06-09-2012>
-- Description:	<Inclusion de Datos Tabla Empleados>
-- Error Values: 
--		-1: Área No existe
--		-2: Área existe
-- =====================================================================================================
CREATE PROCEDURE [dbo].[spModificarPopUp]
@IDPopUp int,
@Titulo	varchar(500),
@Contenido	varchar(6000),
@FechaDesde	smalldatetime,
@FechaHasta	smalldatetime,
@ImgFondo image,
@NombreImagenFondo varchar(300),
@ImgFondoLong int,
@Status	char(1),
@TotalFilas int OUTPUT
AS
BEGIN
	BEGIN
		UPDATE PopUp
		SET Titulo = @Titulo, Contenido=@Contenido, FechaDesde=@FechaDesde, FechaHasta=@FechaHasta, ImgFondo = @ImgFondo, NombreImagenFondo = @NombreImagenFondo, ImgFondoLong = @ImgFondoLong, Status=@Status
		WHERE IDPopUp = @IDPopUp 
		SELECT @TotalFilas = @@ROWCOUNT;
	END
END



GO
/****** Object:  StoredProcedure [dbo].[spModificarUsuario]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--  = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
-- Author:		<Ligia Puertas>
-- Create date: <06-09-2012>
-- Description:	<Inclusion de Datos Tabla Empleados>
-- Error Values: 
--		-1: Área No existe
--		-2: Área existe
--  = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
CREATE PROCEDURE [dbo].[spModificarUsuario]
@IDUsuario	int,
@Usuario varchar(50),
@Nombre	varchar(100),
@Status	char(1),
@StatusBloqueo char(1),
@IntentosFallidos int,
@TotalFilas int OUTPUT
AS
BEGIN
	BEGIN
		SET NOCOUNT ON;
		UPDATE Usuario
		SET Usuario = @Usuario, Nombre = @Nombre, Status = @Status, StatusBloqueo = @StatusBloqueo, IntentosFallidos = @IntentosFallidos
		WHERE IDUsuario = @IDUsuario
		SELECT @TotalFilas = @@ROWCOUNT
	END
END














GO
/****** Object:  StoredProcedure [dbo].[spModificarUsuariosClave]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--  = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
-- Author:		<Ligia Puertas>
-- Create date: <06-09-2012>
-- Description:	<Inclusion de Datos Tabla Empleados>
-- Error Values: 
--		-1: Área No existe
--		-2: Área existe
--  = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
CREATE PROCEDURE [dbo].[spModificarUsuariosClave]
	@IDUsuario int,
	@ClaveNueva varchar(100),
	@ClaveReseteada char(1),
	@TotalFilas int OUTPUT
AS
BEGIN
	BEGIN
		SET NOCOUNT ON;
		UPDATE Usuario
		SET Clave = @ClaveNueva, ClaveReseteada = @ClaveReseteada
		WHERE IDUsuario = @IDUsuario;
		SELECT @TotalFilas = @@ROWCOUNT
	END
END












GO
/****** Object:  StoredProcedure [dbo].[spModificarUsuariosIncIntentosFallidos]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--  = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
-- Author:		<Ligia Puertas>
-- Create date: <06-09-2012>
-- Description:	<Inclusion de Datos Tabla Empleados>
-- Error Values: 
--		-1: Área No existe
--		-2: Área existe
--  = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
CREATE PROCEDURE [dbo].[spModificarUsuariosIncIntentosFallidos]
	@IDUsuario int,
	@TotalFilasIF int OUTPUT,
	@TotalFilasUB int OUTPUT
AS
BEGIN
	BEGIN
		DECLARE @TotalIntentosFallidos int;
		BEGIN TRANSACTION
			UPDATE Usuario
			SET IntentosFallidos = IntentosFallidos + 1
			WHERE IDUsuario = @IDUsuario;
			SELECT @TotalFilasIF = @@ROWCOUNT;
			SELECT @TotalIntentosFallidos = IntentosFallidos FROM Usuario WHERE IDUsuario = @IDUsuario;
			IF (@TotalIntentosFallidos > 3)
			BEGIN
				UPDATE Usuario
				SET StatusBloqueo = '1'
				WHERE IDUsuario = @IDUsuario AND IntentosFallidos >= 3 AND STATUS = 1
				SELECT @TotalFilasUB = @@ROWCOUNT
			END
			ELSE SET @TotalFilasUB = 0;
		COMMIT
	END
END






















GO
/****** Object:  StoredProcedure [dbo].[spModificarUsuarioTodo]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spModificarUsuarioTodo]
@IDUsuario	int,
@Usuario varchar(50),
@Nombre	varchar(100),
@Status	char(1),
@StatusBloqueo char(1),
@IntentosFallidos int,
@Clave varchar(100),
@TotalFilas int OUTPUT
AS
BEGIN
	BEGIN
		SET NOCOUNT ON;
		UPDATE Usuario
		SET Usuario = @Usuario, 
			Nombre = @Nombre, 
			Status = @Status, 
			StatusBloqueo = @StatusBloqueo, 
			Clave = @Clave,
			IntentosFallidos = @IntentosFallidos
		WHERE IDUsuario = @IDUsuario
		SELECT @TotalFilas = @@ROWCOUNT
	END
END















GO
/****** Object:  StoredProcedure [dbo].[spURLFeedsBuscarNRegistros]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spURLFeedsBuscarNRegistros]
@NroRegistros INT
AS
BEGIN
	BEGIN
		SELECT TOP (@NroRegistros) 
			IDURLFeed, 
			Titulo, 
			URLFeed, 
			TipoFeed, 
			Propietario,
			Estado
		FROM URLFeeds
		WHERE Estado = '1'
		ORDER BY Propietario DESC, Titulo
	END
END


















GO
/****** Object:  StoredProcedure [dbo].[spURLFeedsEliminar]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spURLFeedsEliminar]
@IDURLFeed int,
@TotalFilas int OUTPUT
AS
BEGIN
	BEGIN
		SET NOCOUNT OFF;
		DELETE FROM URLFeeds 
		WHERE IDURLFeed = @IDURLFeed
		SELECT @TotalFilas = @@ROWCOUNT
		SET NOCOUNT ON;
	END
END













GO
/****** Object:  StoredProcedure [dbo].[spURLFeedsIncluir]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spURLFeedsIncluir]
@Titulo varchar(200),
@IDURLFeed int OUTPUT,
@URLFeed varchar(1000),
@TipoFeed varchar(4),
@Propietario char(1)
AS
BEGIN
	BEGIN
		SET @IDURLFeed  = 0;
		SET NOCOUNT OFF;
		INSERT INTO URLFeeds (Titulo, URLFeed, TipoFeed, Propietario) 
		VALUES (@Titulo, @URLFeed, @TipoFeed, @Propietario)
		SET @IDURLFeed  = SCOPE_IDENTITY();
		SET NOCOUNT ON;
	END
END















GO
/****** Object:  StoredProcedure [dbo].[spURLFeedsModificar]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spURLFeedsModificar]
@Titulo varchar(200),
@IDURLFeed int,
@URLFeed varchar(1000),
@TipoFeed varchar(4),
@Propietario char(1),
@TotalFilas int OUTPUT
AS
BEGIN
	BEGIN
		SET NOCOUNT OFF;
		UPDATE URLFeeds 
		SET Titulo = @Titulo,
			URLFeed = @URLFeed,
			TipoFeed = @TipoFeed,
			Propietario = @Propietario
		WHERE IDURLFeed = @IDURLFeed
		SELECT @TotalFilas = @@ROWCOUNT
		SET NOCOUNT ON;
	END
END













GO
/****** Object:  Table [dbo].[Categoria]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categoria](
	[CategoriaID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_Categoria] PRIMARY KEY CLUSTERED 
(
	[CategoriaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Comentario]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comentario](
	[ComentarioID] [int] IDENTITY(1,1) NOT NULL,
	[PostID] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Nombre] [nvarchar](200) NOT NULL,
	[Url] [nvarchar](200) NOT NULL,
	[Contenido] [ntext] NOT NULL,
 CONSTRAINT [PK_Comentario] PRIMARY KEY CLUSTERED 
(
	[ComentarioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Empleados]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Empleados](
	[IDEmpleado] [int] IDENTITY(1,1) NOT NULL,
	[TipoID] [varchar](1) NOT NULL,
	[IDNumero] [varchar](12) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Apellido] [varchar](50) NOT NULL,
	[Sexo] [char](1) NOT NULL,
	[FechaNacimiento] [smalldatetime] NOT NULL,
	[NumSeguroSocial] [varchar](10) NOT NULL,
	[ImgFoto] [image] NOT NULL,
	[NombreFoto] [varchar](300) NOT NULL,
	[ImgFotoLong] [int] NOT NULL,
	[PinBB] [varchar](10) NOT NULL,
	[StatusPubDatos] [char](1) NOT NULL,
	[CodTipoEmpleado] [char](2) NOT NULL,
	[CodAreaTlfOficina] [varchar](4) NOT NULL,
	[NumTlfOficina] [varchar](10) NOT NULL,
	[CodAreaTlfMovil] [varchar](4) NOT NULL,
	[NumTlfMovil] [varchar](10) NOT NULL,
	[DescCargo] [varchar](300) NOT NULL,
	[FecIngreso] [datetime] NOT NULL,
	[Status] [char](1) NOT NULL,
 CONSTRAINT [IDEmpleado] PRIMARY KEY CLUSTERED 
(
	[IDEmpleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Feeds]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Feeds](
	[IDFeeds] [int] IDENTITY(1,1) NOT NULL,
	[NumMaxFeeds] [int] NOT NULL,
	[HoraGeneracion] [smalldatetime] NOT NULL,
	[RutaGeneracion] [varchar](300) NOT NULL,
 CONSTRAINT [PK_Feeds] PRIMARY KEY CLUSTERED 
(
	[IDFeeds] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[IdiomaPaisRegion]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IdiomaPaisRegion](
	[IDIdiomaPaisRegion] [int] IDENTITY(1,1) NOT NULL,
	[CodIdiomaPaisRegion] [varchar](10) NOT NULL,
	[NomIdiomaPaisRegion] [varchar](100) NOT NULL,
	[Status] [char](1) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Noticias]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Noticias](
	[IDNoticia] [int] IDENTITY(1,1) NOT NULL,
	[CodNoticia] [varchar](50) NOT NULL,
	[TitNoticia] [varchar](100) NOT NULL,
	[SubTitNoticia] [varchar](100) NOT NULL,
	[TextoNoticia] [varchar](350) NOT NULL,
	[EnlaceNoticia] [varchar](500) NOT NULL,
	[FechaNoticia] [smalldatetime] NOT NULL,
	[IncluirEnRSS] [char](1) NOT NULL,
	[FechaHoraPublicacion] [smalldatetime] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PopUp]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PopUp](
	[IDPopUp] [int] IDENTITY(1,1) NOT NULL,
	[Titulo] [nvarchar](max) NULL,
	[Contenido] [varchar](max) NULL,
	[FechaDesde] [smalldatetime] NULL,
	[FechaHasta] [smalldatetime] NULL,
	[ImgFondo] [image] NULL,
	[NombreImagenFondo] [varchar](300) NULL,
	[ImgFondoLong] [int] NULL,
	[Status] [char](10) NULL,
	[Enlace] [varchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Post]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Post](
	[PostID] [int] IDENTITY(1,1) NOT NULL,
	[Titulo] [nvarchar](200) NOT NULL,
	[PosteadoPor] [nvarchar](200) NOT NULL,
	[Descripcion] [ntext] NOT NULL,
	[Contenido] [ntext] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Publicado] [bit] NOT NULL,
	[Comentarios] [int] NOT NULL,
	[ImgFondo] [image] NULL,
	[NombreImagenFondo] [varchar](300) NULL,
	[ImgFondoLong] [int] NOT NULL,
	[GenerarRSS] [bit] NOT NULL,
 CONSTRAINT [PK_Post] PRIMARY KEY CLUSTERED 
(
	[PostID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PostCategoria]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostCategoria](
	[PostID] [int] NOT NULL,
	[CategoriaID] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[URLFeeds]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[URLFeeds](
	[IDURLFeed] [int] IDENTITY(1,1) NOT NULL,
	[Titulo] [varchar](200) NOT NULL,
	[URLFeed] [varchar](1000) NOT NULL,
	[TipoFeed] [varchar](4) NOT NULL,
	[Propietario] [char](1) NOT NULL,
	[Estado] [char](1) NOT NULL,
 CONSTRAINT [PK_URLFeeds] PRIMARY KEY CLUSTERED 
(
	[IDURLFeed] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_RSSUrl] UNIQUE NONCLUSTERED 
(
	[URLFeed] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuario](
	[IDUsuario] [int] IDENTITY(1,1) NOT NULL,
	[Usuario] [varchar](50) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Clave] [varchar](100) NOT NULL,
	[Status] [char](1) NOT NULL,
	[StatusBloqueo] [char](1) NOT NULL,
	[IntentosFallidos] [int] NOT NULL,
	[FechaUltimaConexion] [datetime] NOT NULL,
	[ClaveReseteada] [char](1) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[VT_ProximosAniversarios]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VT_ProximosAniversarios]
AS
SELECT     IDEmpleado, Nombre, Apellido, DescCargo, FecIngreso, CONVERT(datetime, RIGHT('00' + CONVERT(VARCHAR, DATEPART(DAY, FecIngreso)), 2) 
                      + CAST('-' AS VARCHAR) + RIGHT('00' + CONVERT(VARCHAR, DATEPART(MONTH, FecIngreso)), 2) + CAST('-' AS VARCHAR) + CAST(DATEPART(YEAR, GETDATE()) 
                      AS VARCHAR)) AS FechaAniversario, RIGHT('00' + CONVERT(VARCHAR, DATEPART(DAY, FecIngreso)), 2) + CAST('/' AS VARCHAR) + RIGHT('00' + CONVERT(VARCHAR, 
                      DATEPART(MONTH, FecIngreso)), 2) AS DiaMesAniversario
FROM         dbo.Empleados

GO
/****** Object:  View [dbo].[VT_ProximosCumpleanos]    Script Date: 20/02/2018 12:05:25 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VT_ProximosCumpleanos]
AS
SELECT     IDEmpleado, Nombre, Apellido, DescCargo, FechaNacimiento, CONVERT(datetime, RIGHT('00' + CONVERT(VARCHAR, DATEPART(DAY, FechaNacimiento)), 2) 
                      + CAST('-' AS VARCHAR) + RIGHT('00' + CONVERT(VARCHAR, DATEPART(MONTH, FechaNacimiento)), 2) + CAST('-' AS VARCHAR) + CAST(DATEPART(YEAR, GETDATE()) 
                      AS VARCHAR)) AS FechaCumpleanio, RIGHT('00' + CONVERT(VARCHAR, DATEPART(DAY, FechaNacimiento)), 2) + CAST('/' AS VARCHAR) 
                      + RIGHT('00' + CONVERT(VARCHAR, DATEPART(MONTH, FechaNacimiento)), 2) AS DiaMesCumpleanios
FROM         dbo.Empleados

GO
ALTER TABLE [dbo].[Empleados] ADD  CONSTRAINT [DF_Empleados_PinBB]  DEFAULT ('') FOR [PinBB]
GO
ALTER TABLE [dbo].[IdiomaPaisRegion] ADD  CONSTRAINT [DF_IdiomaPaisRegion_Status]  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[Noticias] ADD  CONSTRAINT [DF_Noticias_IncluirEnRSS]  DEFAULT ((0)) FOR [IncluirEnRSS]
GO
ALTER TABLE [dbo].[Noticias] ADD  CONSTRAINT [DF_Noticias_FechaHoraPublicacion]  DEFAULT (getdate()) FOR [FechaHoraPublicacion]
GO
ALTER TABLE [dbo].[PopUp] ADD  CONSTRAINT [DF_PopUp_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Post] ADD  CONSTRAINT [DF_Post_Comentario]  DEFAULT ((0)) FOR [Comentarios]
GO
ALTER TABLE [dbo].[Post] ADD  CONSTRAINT [DF_Post_ImgFondoLong]  DEFAULT ((0)) FOR [ImgFondoLong]
GO
ALTER TABLE [dbo].[Post] ADD  CONSTRAINT [DF_Post_GenerarRSS]  DEFAULT ((1)) FOR [GenerarRSS]
GO
ALTER TABLE [dbo].[URLFeeds] ADD  CONSTRAINT [DF_URLFeeds_Titulo]  DEFAULT ('') FOR [Titulo]
GO
ALTER TABLE [dbo].[URLFeeds] ADD  CONSTRAINT [DF_URLFeeds_TipoFeed]  DEFAULT ('RSS') FOR [TipoFeed]
GO
ALTER TABLE [dbo].[URLFeeds] ADD  CONSTRAINT [DF_URLFeeds_Propio]  DEFAULT ((0)) FOR [Propietario]
GO
ALTER TABLE [dbo].[URLFeeds] ADD  CONSTRAINT [DF_URLFeeds_Estado]  DEFAULT ((1)) FOR [Estado]
GO
ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [DF_Usuario_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [DF_Usuario_StatusBloqueo]  DEFAULT ((1)) FOR [StatusBloqueo]
GO
ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [DF_Usuario_IntentosFallidos]  DEFAULT ((0)) FOR [IntentosFallidos]
GO
ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [DF_Usuario_FechaUltimaConexion]  DEFAULT (getdate()) FOR [FechaUltimaConexion]
GO
ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [DF_Usuario_ClaveReseteada]  DEFAULT ((1)) FOR [ClaveReseteada]
GO
ALTER TABLE [dbo].[Comentario]  WITH CHECK ADD  CONSTRAINT [FK_Comentario_Post] FOREIGN KEY([PostID])
REFERENCES [dbo].[Post] ([PostID])
GO
ALTER TABLE [dbo].[Comentario] CHECK CONSTRAINT [FK_Comentario_Post]
GO
ALTER TABLE [dbo].[PostCategoria]  WITH CHECK ADD  CONSTRAINT [FK_PostCategoria_Categoria] FOREIGN KEY([CategoriaID])
REFERENCES [dbo].[Categoria] ([CategoriaID])
GO
ALTER TABLE [dbo].[PostCategoria] CHECK CONSTRAINT [FK_PostCategoria_Categoria]
GO
ALTER TABLE [dbo].[PostCategoria]  WITH CHECK ADD  CONSTRAINT [FK_PostCategoria_Post] FOREIGN KEY([PostID])
REFERENCES [dbo].[Post] ([PostID])
GO
ALTER TABLE [dbo].[PostCategoria] CHECK CONSTRAINT [FK_PostCategoria_Post]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[19] 4[43] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Empleados"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 236
            End
            DisplayFlags = 280
            TopColumn = 12
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2400
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VT_ProximosAniversarios'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VT_ProximosAniversarios'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Empleados"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 236
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VT_ProximosCumpleanos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VT_ProximosCumpleanos'
GO
