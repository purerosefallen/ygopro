--高速决斗技能-少女的行动
Duel.LoadScript("speed_duel_common.lua")
function c100730253.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730253.skill,c100730253.con,aux.Stringid(100730253,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730253.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsPlayerCanSpecialSummon(tp)
		and Duel.IsExistingMatchingCard(c100730253.filter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c100730253.filter,tp,LOCATION_DECK,0,1,nil) 
end
function c100730253.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730253)
	local g=Duel.SelectMatchingCard(tp,c100730253.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoHand(g,tp,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
	local g2=Duel.SelectMatchingCard(tp,c100730253.filter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g2:GetFirst()
	Duel.SpecialSummon(tc,0,tp,tp,true,true,POS_FACEUP)
end
function c100730253.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsRace(RACE_FAIRY) and c:IsDefense(600)
end