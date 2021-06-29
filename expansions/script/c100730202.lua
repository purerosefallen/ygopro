--高速决斗技能-教师的指导
Duel.LoadScript("speed_duel_common.lua")
function c100730202.initial_effect(c)
	if not c100730202.UsedLP then
		c100730202.UsedLP={}
		c100730202.UsedLP[0]=0
		c100730202.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelAtMainPhase(c,c100730202.skill,c100730202.con,aux.Stringid(100730202,1))
	aux.SpeedDuelAtMainPhase(c,c100730202.skill1,c100730202.con1,aux.Stringid(100730202,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730202.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and aux.DecreasedLP[tp]-c100730202.UsedLP[tp] >= 1500
		and Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)~=0
end
function c100730202.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730202,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730202)
		Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730202,1))
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
function c100730202.con1(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,nil)
end
function c100730202.skill1(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,1,nil)
	local c=g:GetFirst()
	if c then
		Duel.Hint(HINT_CARD,1-tp,100730202)
		Duel.SendtoDeck(c,1-tp,nil,0,REASON_RULE)
		Duel.ShuffleDeck(1-tp)
	end
end