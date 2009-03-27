
local L = tek_locale


local _, class = UnitClass("player")


tek_register("Interface\\Icons\\Spell_Holy_Aspiration", function(self)
	local hit = math.min(100, 83 + GetCombatRatingBonus(CR_HIT_SPELL))
	local crit = GetSpellCritChance(1)

	local hasHP = UnitAura("player", "Heroic Presence")
	if hasHP then hit = hit + 1 end

	local _, sf, sfv, mis, misv, bop, bopv, iff, iffv, sup, supv, cat, catv, af, afv, pre, prev, vir, virv

	if class == "PRIEST" then
		sf, _, _, _, sfv = GetTalentInfo(3,6)
		mis, _, _, _, misv = GetTalentInfo(3,22)
		if sfv > 0 then hit, sfv = hit + sfv, "+"..sfv.."%" else sfv = nil end
		if misv > 0 then hit, misv = hit + misv, "+"..misv.."%" else misv = nil end
	end

	if class == "DRUID" then
		bop, _, _, _, bopv = GetTalentInfo(1,17)
		iff, _, _, _, iffv = GetTalentInfo(1,20)
		if bopv > 0 then hit, bopv = hit + bopv*2, "+"..(bopv*2).."%" else bopv = nil end
		if iffv > 0 then hit, iffv = hit + iffv, "+"..(iffv).."%" else iffv = nil end
	end

	if class == "WARLOCK" then
		sup, _, _, _, supv = GetTalentInfo(1,2)
		cat, _, _, _, catv = GetTalentInfo(3,5)
		if (catv+supv) > 0 then hit = hit + math.max(catv, supv) end
		if supv > 0 then supv = "+"..supv.."%" else supv = nil end
		if catv > 0 then catv = "+"..catv.."%" else catv = nil end
	end

	if class == "MAGE" then
		af, _, _, _, afv = GetTalentInfo(1,2)
		pre, _, _, _, prev = GetTalentInfo(3,6)
		if afv > 0 then hit, afv = hit + afv, "+"..afv.."%" else afv = nil end
		if prev > 0 then hit, prev = hit + prev, "+"..prev.."%" else prev = nil end
	end

	if class == "DEATHKNIGHT" then
		vir, _, _, _, virv = GetTalentInfo(3,5)
		if virv > 0 then hit, virv = hit + virv, "+"..virv.."%" else virv = nil end
	end

	if class == "SHAMAN" then
		vir, _, _, _, virv = GetTalentInfo(1,14)
		if virv > 0 then hit, virv = hit + virv, "+"..virv.."%" else virv = nil end
	end

	local miss = 100 - hit
	crit = crit * hit/100
	hit = hit - crit


 	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:ClearLines()

	GameTooltip:AddLine("Spell Table", 1,1,1)

	GameTooltip:AddDoubleLine(L["Critical"], string.format("%.2f%%", crit), nil,nil,nil, .5,1,.5)
	GameTooltip:AddDoubleLine(L["Hit"], string.format("%.2f%%", hit), nil,nil,nil, 1,1,1)
	GameTooltip:AddDoubleLine(L["Miss"], string.format("%.2f%%", miss), nil,nil,nil, 1,.5,0)

	if hasHP or sfv or misv or sfv or bopv or iffv or supv or catv or afv or prev or virv then
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine("Hit Bonuses", 1,1,1)
		if hasHP then GameTooltip:AddDoubleLine(hasHP, "+1%", nil,nil,nil, 1,1,1) end
		if misv  then GameTooltip:AddDoubleLine(mis.."*", misv, nil,nil,nil, 1,1,1) end
		if sfv   then GameTooltip:AddDoubleLine(sf.."\194\186", sfv, nil,nil,nil, 1,1,1) end
		if bopv  then GameTooltip:AddDoubleLine(bop, bopv, nil,nil,nil, 1,1,1) end
		if iffv  then GameTooltip:AddDoubleLine(iff.."*", iffv, nil,nil,nil, 1,1,1) end
		if supv  then GameTooltip:AddDoubleLine(sup.."\194\186", supv, nil,nil,nil, 1,1,1) end
		if catv  then GameTooltip:AddDoubleLine(cat.."\194\185", catv, nil,nil,nil, 1,1,1) end
		if virv  then GameTooltip:AddDoubleLine(vir, virv, nil,nil,nil, 1,1,1) end
		if prev  then GameTooltip:AddDoubleLine(pre, prev, nil,nil,nil, 1,1,1) end
		if afv   then GameTooltip:AddDoubleLine(af.."\194\186", afv, nil,nil,nil, 1,1,1) end
--~ 		� � � � � � �
--~ 		†‡•º¹²³
--~ 		\226\128\160 \226\128\161 \226\128\162 \194\186 \194\185 \194\178 \194\179

		if misv or iffv then GameTooltip:AddLine("*When debuff is applied", 0.5, 0.5, 1) end
		if sfv then GameTooltip:AddLine("\194\186Shadow spells only", 0.5, 0.5, 1) end
		if supv then GameTooltip:AddLine("\194\186Affliction spells only", 0.5, 0.5, 1) end
		if catv then GameTooltip:AddLine("\194\185Destruction spells only", 0.5, 0.5, 1) end
		if afv  then GameTooltip:AddLine("\194\186Arcane spells only", 0.5, 0.5, 1) end
	end

	GameTooltip:AddLine(" ")
	GameTooltip:AddLine("All values are vs. mobs\n3 levels above the player.", 0,1,0, true)

	GameTooltip:Show()
end)


tek_locale, tek_register = nil
