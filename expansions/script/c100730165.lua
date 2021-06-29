--高速决斗技能-鹰身的战斗
Duel.LoadScript("speed_duel_common.lua")
function c100730165.initial_effect(c)
	if not c100730165.UsedLP then
		c100730165.UsedLP={}
		c100730165.UsedLP[0]=0
		c100730165.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelReplaceDraw(c,c100730165.skill,c100730165.con,aux.Stringid(100730165,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730165.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp 
		and aux.DecreasedLP[tp]-c100730165.UsedLP[tp] >= 1800
end
function c100730165.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730165,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730165)
		Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730165,1))
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CODE)
		getmetatable(e:GetHandler()).announce_filter={TYPE_MONSTER+TYPE_SPELL+TYPE_TRAP,OPCODE_ISTYPE,TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ+TYPE_LINK,OPCODE_ISTYPE,OPCODE_NOT,OPCODE_AND}
		local ac=Duel.AnnounceCard(tp,table.unpack(getmetatable(e:GetHandler()).announce_filter))
		local c=Duel.CreateToken(tp,ac)
		if c:IsSetCard(0x64) then
			Duel.SendtoDeck(c,tp,0,REASON_RULE)
		else Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730165,2))
		end 
	end
end