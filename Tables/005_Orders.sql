CREATE TABLE [dbo].[Orders](
	[IdOrder] [int] IDENTITY(1,1) NOT NULL,
	[IdOrderState] [int] NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Observation] [varchar](1000) NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[DeleteDate] [datetime] NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[IdOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


