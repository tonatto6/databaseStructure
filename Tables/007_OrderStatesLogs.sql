CREATE TABLE [dbo].[OrderStatesLogs](
	[IdOrderStateLog] [int] IDENTITY(1,1) NOT NULL,
	[IdOrder] [int] NOT NULL,
	[IdOrderState] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_OrderStatesLogs] PRIMARY KEY CLUSTERED 
(
	[IdOrderStateLog] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


