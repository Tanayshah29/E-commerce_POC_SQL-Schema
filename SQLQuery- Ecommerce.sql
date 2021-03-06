USE [master]
GO

/****** Object:  Database [ECOM]    Script Date: 06/03/2021 2:43:29 PM ******/
CREATE DATABASE [ECOM]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ECOM', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ECOM.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ECOM_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ECOM_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ECOM].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [ECOM] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [ECOM] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [ECOM] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [ECOM] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [ECOM] SET ARITHABORT OFF 
GO

ALTER DATABASE [ECOM] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [ECOM] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [ECOM] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [ECOM] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [ECOM] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [ECOM] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [ECOM] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [ECOM] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [ECOM] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [ECOM] SET  DISABLE_BROKER 
GO

ALTER DATABASE [ECOM] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [ECOM] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [ECOM] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [ECOM] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [ECOM] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [ECOM] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [ECOM] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [ECOM] SET RECOVERY FULL 
GO

ALTER DATABASE [ECOM] SET  MULTI_USER 
GO

ALTER DATABASE [ECOM] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [ECOM] SET DB_CHAINING OFF 
GO

ALTER DATABASE [ECOM] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [ECOM] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [ECOM] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [ECOM] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO

ALTER DATABASE [ECOM] SET QUERY_STORE = OFF
GO

ALTER DATABASE [ECOM] SET  READ_WRITE 
GO

/****** Object:  Table [dbo].[Address_Type]    Script Date: 06/03/2021 2:27:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Address_Type](
	[Address_Type_Code] [int] IDENTITY(1,1) NOT NULL,
	[Address_Type_Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_Address_Type] PRIMARY KEY CLUSTERED 
(
	[Address_Type_Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Addresses]    Script Date: 06/03/2021 2:28:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Addresses](
	[Address_Id] [int] NOT NULL,
	[Address_Line1] [varchar](100) NOT NULL,
	[Address_Line2] [varchar](50) NULL,
	[City] [varchar](20) NOT NULL,
	[Postal_Code] [varchar](20) NOT NULL,
	[State] [varchar](20) NOT NULL,
	[Country] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Addresses] PRIMARY KEY CLUSTERED 
(
	[Address_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Cart]    Script Date: 06/03/2021 2:28:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Cart](
	[Card_Id] [int] IDENTITY(1,1) NOT NULL,
	[Customer_Id] [int] NULL,
	[sessionId] [varchar](100) NOT NULL,
	[token] [varchar](100) NOT NULL,
	[status] [smallint] NOT NULL,
	[createdAt] [datetime] NOT NULL,
	[updatedAt] [datetime] NULL,
	[content] [varchar](100) NULL,
 CONSTRAINT [PK_Cart] PRIMARY KEY CLUSTERED 
(
	[Card_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Cart] ADD  CONSTRAINT [DF_Cart_Customer_Id]  DEFAULT (NULL) FOR [Customer_Id]
GO

ALTER TABLE [dbo].[Cart] ADD  CONSTRAINT [DF_Cart_status]  DEFAULT ((0)) FOR [status]
GO

ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Customers] FOREIGN KEY([Customer_Id])
REFERENCES [dbo].[Customers] ([User_Id])
GO

ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Customers]
GO

/****** Object:  Table [dbo].[Cart_Item]    Script Date: 06/03/2021 2:29:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Cart_Item](
	[Card_Item_id] [int] IDENTITY(1,1) NOT NULL,
	[Product_Id] [int] NOT NULL,
	[price] [float] NOT NULL,
	[quantity] [float] NOT NULL,
	[active] [tinyint] NOT NULL,
	[createdAt] [datetime] NOT NULL,
	[updatedAt] [datetime] NULL,
	[context] [varchar](100) NULL,
 CONSTRAINT [PK_Cart_Item] PRIMARY KEY CLUSTERED 
(
	[Card_Item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Cart_Item] ADD  CONSTRAINT [DF_Cart_Item_price]  DEFAULT ((0)) FOR [price]
GO

ALTER TABLE [dbo].[Cart_Item] ADD  CONSTRAINT [DF_Cart_Item_quantity]  DEFAULT ((0)) FOR [quantity]
GO

ALTER TABLE [dbo].[Cart_Item] ADD  CONSTRAINT [DF_Cart_Item_updatedAt]  DEFAULT (NULL) FOR [updatedAt]
GO

ALTER TABLE [dbo].[Cart_Item] ADD  CONSTRAINT [DF_Cart_Item_context]  DEFAULT (NULL) FOR [context]
GO

ALTER TABLE [dbo].[Cart_Item]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Item_Cart] FOREIGN KEY([Card_Item_id])
REFERENCES [dbo].[Cart] ([Card_Id])
GO

ALTER TABLE [dbo].[Cart_Item] CHECK CONSTRAINT [FK_Cart_Item_Cart]
GO

ALTER TABLE [dbo].[Cart_Item]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Item_Products] FOREIGN KEY([Product_Id])
REFERENCES [dbo].[Products] ([Product_Id])
GO

ALTER TABLE [dbo].[Cart_Item] CHECK CONSTRAINT [FK_Cart_Item_Products]
GO

/****** Object:  Table [dbo].[Categories]    Script Date: 06/03/2021 2:30:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Categories](
	[Category_Id] [int] NOT NULL,
	[Category_Name] [varchar](50) NOT NULL,
	[Catrgory_Description] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[Category_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Customers]    Script Date: 06/03/2021 2:30:21 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Customers](
	[User_Id] [int] IDENTITY(1,1) NOT NULL,
	[User_FirstName] [nvarchar](30) NULL,
	[User_LastName] [nvarchar](30) NULL,
	[User_Emailid] [nvarchar](50) NOT NULL,
	[User_PhoneNo] [int] NOT NULL,
	[User_Password] [nvarchar](50) NULL,
	[User_status] [nvarchar](30) NULL,
	[User_Create_Date] [date] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[User_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Customers] ADD  CONSTRAINT [status_d]  DEFAULT ('inactive') FOR [User_status]
GO


/****** Object:  Table [dbo].[Customers_Addressess]    Script Date: 06/03/2021 2:30:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Customers_Addressess](
	[Customer_Id] [int] NOT NULL,
	[Address_Id] [int] NOT NULL,
	[Address_Type_code] [int] NOT NULL,
	[Date_From] [date] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Customers_Addressess]  WITH CHECK ADD  CONSTRAINT [FK_Users_Addressess_Address_Type] FOREIGN KEY([Address_Type_code])
REFERENCES [dbo].[Address_Type] ([Address_Type_Code])
GO

ALTER TABLE [dbo].[Customers_Addressess] CHECK CONSTRAINT [FK_Users_Addressess_Address_Type]
GO

ALTER TABLE [dbo].[Customers_Addressess]  WITH CHECK ADD  CONSTRAINT [FK_Users_Addressess_Addresses] FOREIGN KEY([Address_Id])
REFERENCES [dbo].[Addresses] ([Address_Id])
GO

ALTER TABLE [dbo].[Customers_Addressess] CHECK CONSTRAINT [FK_Users_Addressess_Addresses]
GO

ALTER TABLE [dbo].[Customers_Addressess]  WITH CHECK ADD  CONSTRAINT [FK_Users_Addressess_Users] FOREIGN KEY([Customer_Id])
REFERENCES [dbo].[Customers] ([User_Id])
GO

ALTER TABLE [dbo].[Customers_Addressess] CHECK CONSTRAINT [FK_Users_Addressess_Users]
GO

/****** Object:  Table [dbo].[Order_Item]    Script Date: 06/03/2021 2:30:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Order_Item](
	[Order_Item_Id] [int] IDENTITY(1,1) NOT NULL,
	[Order_ID] [int] NOT NULL,
	[Product_Id] [int] NOT NULL,
	[price] [float] NOT NULL,
	[quantity] [smallint] NOT NULL,
	[createdAt] [datetime] NOT NULL,
	[updatedAt] [datetime] NULL,
	[content] [text] NULL,
 CONSTRAINT [PK_Order_Item] PRIMARY KEY CLUSTERED 
(
	[Order_Item_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Order_Item] ADD  CONSTRAINT [DF_Order_Item_price]  DEFAULT ((0)) FOR [price]
GO

ALTER TABLE [dbo].[Order_Item] ADD  CONSTRAINT [DF_Order_Item_quantity]  DEFAULT ((0)) FOR [quantity]
GO

ALTER TABLE [dbo].[Order_Item] ADD  CONSTRAINT [DF_Order_Item_updatedAt]  DEFAULT (NULL) FOR [updatedAt]
GO

ALTER TABLE [dbo].[Order_Item]  WITH CHECK ADD  CONSTRAINT [FK_Order_Item_Orders] FOREIGN KEY([Order_ID])
REFERENCES [dbo].[Orders] ([Order_id])
GO

ALTER TABLE [dbo].[Order_Item] CHECK CONSTRAINT [FK_Order_Item_Orders]
GO

ALTER TABLE [dbo].[Order_Item]  WITH CHECK ADD  CONSTRAINT [FK_Order_Item_Products] FOREIGN KEY([Product_Id])
REFERENCES [dbo].[Products] ([Product_Id])
GO

ALTER TABLE [dbo].[Order_Item] CHECK CONSTRAINT [FK_Order_Item_Products]
GO

/****** Object:  Table [dbo].[Orders]    Script Date: 06/03/2021 2:31:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Orders](
	[Order_id] [int] NOT NULL,
	[Customer_id] [int] NOT NULL,
	[Payment_Method_id] [int] NOT NULL,
	[Order_Date] [date] NOT NULL,
	[Shipping_Date] [date] NOT NULL,
	[Ship_Name] [varchar](50) NOT NULL,
	[Ship_Address] [nvarchar](100) NOT NULL,
	[Ship_City] [varchar](20) NOT NULL,
	[Ship_State] [varchar](10) NOT NULL,
	[Ship_Postal_Code] [varchar](10) NOT NULL,
	[Ship_Country] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[Order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([Customer_id])
REFERENCES [dbo].[Customers] ([User_Id])
GO

ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customers]
GO

ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Payment_Methods] FOREIGN KEY([Payment_Method_id])
REFERENCES [dbo].[Payment_Methods] ([Payment_Method_Id])
GO

ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Payment_Methods]
GO

/****** Object:  Table [dbo].[Payment_Method_Type]    Script Date: 06/03/2021 2:31:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Payment_Method_Type](
	[Payment_Method_Type_ID] [int] IDENTITY(1,1) NOT NULL,
	[Payment_Method_Description] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Payment_Method_Type] PRIMARY KEY CLUSTERED 
(
	[Payment_Method_Type_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Payment_Methods]    Script Date: 06/03/2021 2:31:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Payment_Methods](
	[Payment_Method_Id] [int] IDENTITY(1,1) NOT NULL,
	[Customer_id] [int] NOT NULL,
	[Payment_Method_Type_Id] [int] NOT NULL,
	[Card_Number] [varchar](20) NULL,
	[Valid_From_Year] [int] NULL,
	[Valid_Till_Year] [int] NULL,
 CONSTRAINT [PK_Payment_Methods] PRIMARY KEY CLUSTERED 
(
	[Payment_Method_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Payment_Methods]  WITH CHECK ADD  CONSTRAINT [FK_Payment_Methods_Payment_Method_Type] FOREIGN KEY([Payment_Method_Type_Id])
REFERENCES [dbo].[Payment_Method_Type] ([Payment_Method_Type_ID])
GO

ALTER TABLE [dbo].[Payment_Methods] CHECK CONSTRAINT [FK_Payment_Methods_Payment_Method_Type]
GO

ALTER TABLE [dbo].[Payment_Methods]  WITH CHECK ADD  CONSTRAINT [FK_Payment_Methods_Users] FOREIGN KEY([Customer_id])
REFERENCES [dbo].[Customers] ([User_Id])
GO

ALTER TABLE [dbo].[Payment_Methods] CHECK CONSTRAINT [FK_Payment_Methods_Users]
GO

/****** Object:  Table [dbo].[Product_Category]    Script Date: 06/03/2021 2:31:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Product_Category](
	[product_id] [int] NOT NULL,
	[category_id] [int] NOT NULL,
	[product_CategoryName] [varchar](30) NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Product_Category]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category_Products] FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([Product_Id])
GO

ALTER TABLE [dbo].[Product_Category] CHECK CONSTRAINT [FK_Product_Category_Products]
GO

ALTER TABLE [dbo].[Product_Category]  WITH CHECK ADD  CONSTRAINT [FK_Sub Categories_Categories] FOREIGN KEY([category_id])
REFERENCES [dbo].[Categories] ([Category_Id])
GO

ALTER TABLE [dbo].[Product_Category] CHECK CONSTRAINT [FK_Sub Categories_Categories]
GO

/****** Object:  Table [dbo].[Products]    Script Date: 06/03/2021 2:31:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Products](
	[Product_Id] [int] IDENTITY(1,1) NOT NULL,
	[Category_Id] [int] NOT NULL,
	[Product_Name] [varchar](30) NOT NULL,
	[Product_Description] [nvarchar](max) NULL,
	[Product_Unit_Price] [decimal](18, 2) NOT NULL,
	[Product_Unit_Instock] [int] NOT NULL,
	[Product_Availability_Status] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Product_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories] FOREIGN KEY([Category_Id])
REFERENCES [dbo].[Categories] ([Category_Id])
GO

ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories]
GO

USE [ECOM]
GO

/****** Object:  View [dbo].[View_Cart-Items]    Script Date: 06/03/2021 2:37:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[View_Cart-Items]
AS
SELECT        dbo.Customers.User_FirstName, dbo.Customers.User_LastName, dbo.Products.Product_Name, dbo.Cart_Item.updatedAt, dbo.Cart_Item.quantity, dbo.Cart_Item.price, dbo.Cart_Item.active
FROM            dbo.Cart_Item INNER JOIN
                         dbo.Cart ON dbo.Cart_Item.Card_Item_id = dbo.Cart.Card_Id INNER JOIN
                         dbo.Customers ON dbo.Cart.Customer_Id = dbo.Customers.User_Id INNER JOIN
                         dbo.Products ON dbo.Cart_Item.Product_Id = dbo.Products.Product_Id
GO

USE [ECOM]
GO

/****** Object:  View [dbo].[View_Pro_Cat]    Script Date: 06/03/2021 2:42:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[View_Pro_Cat]
AS
SELECT        dbo.Products.Product_Name, dbo.Products.Product_Description, dbo.Categories.Category_Name, dbo.Categories.Catrgory_Description
FROM            dbo.Products INNER JOIN
                         dbo.Categories ON dbo.Products.Category_Id = dbo.Categories.Category_Id
GO















