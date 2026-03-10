CREATE TABLE [dbo].[ProductsTypes](
	[IdProductType] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](100) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[DeleteDate] [datetime] NULL,
 CONSTRAINT [PK_ProductsTypes] PRIMARY KEY CLUSTERED 
(
	[IdProductType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


