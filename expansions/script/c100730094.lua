--高速决斗技能-电子化天使的祝福
Duel.LoadScript("speed_duel_common.lua")
function c100730094.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(81380218,c)
	aux.SpeedDuelReplaceDraw(c,c100730094.skill,c100730094.con,aux.Stringid(100730094,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730094.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp and Duel.GetLP(tp)<=5000
end
function c100730094.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730094,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730094)
		Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730094,1))
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CODE)
		getmetatable(e:GetHandler()).announce_filter={TYPE_RITUAL,OPCODE_ISTYPE,TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ+TYPE_LINK,OPCODE_ISTYPE,OPCODE_NOT,OPCODE_AND}
		local ac=Duel.AnnounceCard(tp,table.unpack(getmetatable(e:GetHandler()).announce_filter))
		local c=Duel.CreateToken(tp,ac)
		if c:IsSetCard(0x2093) then
			Duel.SendtoDeck(c,tp,0,REASON_RULE)
		else Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730094,2))
		end 
	end
end