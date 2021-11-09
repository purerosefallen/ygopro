--高速决斗技能-守护者呼唤
Duel.LoadScript("speed_duel_common.lua")
function c100730137.initial_effect(c)
	if not c100730137.UsedLP then
		c100730137.UsedLP={}
		c100730137.UsedLP[0]=0
		c100730137.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelReplaceDraw(c,c100730137.skill,c100730137.con,aux.Stringid(100730137,1))
	aux.SpeedDuelBeforeDraw(c,c100730137.skill2)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730137.skill2(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730137)
	local tc=Duel.CreateToken(tp,50412166)
	aux.SpeedDuelSendToHandWithExile(tp,tc)
	e:Reset()
end
function c100730137.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp 
		and aux.DecreasedLP[tp]-c100730137.UsedLP[tp] >= 1800
end
function c100730137.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730137,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730137)
		Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730137,1))
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CODE)
		getmetatable(e:GetHandler()).announce_filter={TYPE_MONSTER+TYPE_SPELL+TYPE_TRAP,OPCODE_ISTYPE,TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ+TYPE_LINK,OPCODE_ISTYPE,OPCODE_NOT,OPCODE_AND}
		local ac=Duel.AnnounceCard(tp,table.unpack(getmetatable(e:GetHandler()).announce_filter))
		local c=Duel.CreateToken(tp,ac)
		if c:IsSetCard(0x52) then
			Duel.SendtoDeck(c,tp,0,REASON_RULE)
			Duel.Draw(tp,1,REASON_RULE)
		else Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730137,2))
		end
	end
end