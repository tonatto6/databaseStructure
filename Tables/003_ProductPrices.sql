CREATE TABLE [dbo].[ProductPrices](
	[IdProductPrice] [int] IDENTITY(1,1) NOT NULL,
	[IdProduct] [int] NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[DeleteDate] [datetime] NULL,
 CONSTRAINT [PK_ProductPrices] PRIMARY KEY CLUSTERED 
(
	[IdProductPrice] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


