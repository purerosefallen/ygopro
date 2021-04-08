--高速决斗技能-堕落之王的仆从
Duel.LoadScript("speed_duel_common.lua")
function c100730194.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730194.skill,c100730194.con,aux.Stringid(100730194,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730194.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730194.filter,tp,LOCATION_DECK,0,1,nil)
end
function c100730194.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730194)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c100730194.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
		local g1=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_HAND,0,0,1,nil,29155212)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		if ft<1 or not g1 then return end
		Duel.SpecialSummon(g1,0,tp,tp,true,true,POS_FACEUP)
	end
end
function c100730194.filter(c)
	return c:IsType(TYPE_NORMAL) and c:IsLevelBelow(3) and c:IsRace(RACE_ZOMBIE) and c:IsAbleToGrave()
end
