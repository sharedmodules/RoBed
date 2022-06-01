local MessageEmbed = {};
MessageEmbed.__index = MessageEmbed

function MessageEmbed.new()
	local self = setmetatable(
		{
			config = {Color = '0xFFFFF', Title = 'nothing', Description = 'Nothing', Fields = {}},
			EmbedData = {},
		},
		MessageEmbed
	)

	self.EmbedData = {
		['embeds'] = {{
			['title'] = self.config.Title,
			['description'] = self.config.Description,
			['color'] = tonumber(self.config.Color),
			['type'] = 'rich',
			['fields'] = self.config.Fields
		}}
	}

	return self
end

function MessageEmbed:SetColor(Color)
	self.config.Color = Color
	return self
end

function MessageEmbed:SetDescription(Description)
	self.config.Description = Description
	return self
end

function MessageEmbed:SetTitle(Title)
	self.config.Title = Title
	return self
end

function MessageEmbed:AddFields(Name, Value, InLine)
	local FieldData = {['name'] = Name, ['value'] = Value, ['inline'] = InLine}
	table.insert(self.config.Fields, FieldData)
	return self
end

function MessageEmbed:Send(Url)
	syn.request({
		Url = Url,
		Method = 'POST',
		Headers = {
			['Content-Type'] = 'application/json'
		},
		Body = game:GetService('HttpService'):JSONEncode(self.EmbedData)
	})
end

return MessageEmbed
