CREATE TABLE [dbo].[Products](
	[IdProduct] [int] IDENTITY(1,1) NOT NULL,
	[IdProductType] [int] NOT NULL,
	[Description] [varchar](100) NOT NULL,
	[Available] [bit] NOT NULL,
	[CreteDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[DeleteDate] [datetime] NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[IdProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


