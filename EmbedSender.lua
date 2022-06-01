local MessageEmbed = {};
MessageEmbed.__index = MessageEmbed

function MessageEmbed.new()
	local self = setmetatable({Settings = {Color = '0xFFFFF', Title = 'nothing', Description = 'Nothing', Fields = {}}, Embed = {}}, MessageEmbed)
	self.Embed = {
		['embeds'] = {{
			['title'] = self.Settings.Title,
			['description'] = self.Settings.Description,
			['color'] = tonumber(self.Settings.Color),
			['type'] = 'rich',
			['fields'] = self.Settings.Fields
		}}
	}
	return self
end

function MessageEmbed:SetColor(Color)
	self.Settings.Color = Color
	return self
end

function MessageEmbed:SetDescription(Description)
	self.Settings.Description = Description
	return self
end

function MessageEmbed:SetTitle(Title)
	self.Settings.Title = Title
	return self
end

function MessageEmbed:AddFields(Name, Value, InLine)
	local FieldData = {['name'] = Name, ['value'] = Value, ['inline'] = InLine}
	table.insert(self.Settings.Fields, FieldData)
	return self
end

function MessageEmbed:Send(Url)
	syn.request({
		Url = Url,
		Method = 'POST',
		Headers = {
			['Content-Type'] = 'application/json'
		},
		Body = game:GetService('HttpService'):JSONEncode(self.Embed)
	})
end

return MessageEmbed
