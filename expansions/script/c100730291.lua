--高速决斗技能-教师的指导
Duel.LoadScript("speed_duel_common.lua")
function c100730291.initial_effect(c)
	if not c100730291.UsedLP then
		c100730291.UsedLP={}
		c100730291.UsedLP[0]=0
		c100730291.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelAtMainPhase(c,c100730291.skill,c100730291.con,aux.Stringid(100730291,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730291.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and aux.DecreasedLP[tp]-c100730291.UsedLP[tp] >= 1500
		and Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)~=0
end
function c100730291.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730291,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730291)
		Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730291,1))
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CODE)
		getmetatable(e:GetHandler()).announce_filter={TYPE_MONSTER+TYPE_SPELL+TYPE_TRAP,OPCODE_ISTYPE,TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ+TYPE_LINK,OPCODE_ISTYPE,OPCODE_NOT,OPCODE_AND}
		local ac=Duel.AnnounceCard(tp,table.unpack(getmetatable(e:GetHandler()).announce_filter))
		local g=Duel.GetFieldGroup(tp,0,LOCATION_DECK)
		Duel.ConfirmCards(1-tp,g)
		local sg=g:FilterSelect(1-tp,Card.IsCode,1,1,nil,ac)
		if sg:GetCount()<1 then return end
		Duel.MoveSequence(sg:GetFirst(),0)
	end
end