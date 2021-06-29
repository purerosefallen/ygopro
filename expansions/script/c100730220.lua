--高速决斗技能-大公归来
Duel.LoadScript("speed_duel_common.lua")
function c100730220.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730220.skill,c100730220.con,aux.Stringid(100730220,0))
	aux.SpeedDuelMoveCardToDeckCommon(66506689,c)
	aux.SpeedDuelMoveCardToDeckCommon(18063928,c)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730220.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
	and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,66506689)
	and Duel.IsExistingMatchingCard(c100730220.filter,tp,0,LOCATION_MZONE,1,nil)
end
function c100730220.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730220)
	local g=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_GRAVE,0,1,1,nil,66506689)
	Duel.SendtoDeck(g,nil,0,REASON_RULE)
	local c=Duel.CreateToken(tp,18063928)
	Duel.SendtoHand(c,nil,REASON_RULE)
	if Duel.GetMZoneCount(tp)>0 then
		local c=Duel.CreateToken(tp,42969214)
		Duel.SpecialSummon(c,0,tp,tp,true,true,POS_FACEUP_ATTACK)
	end
end
function c100730220.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsPosition(POS_DEFENSE)
end