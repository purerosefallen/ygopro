--高速决斗技能-究极进化药
Duel.LoadScript("speed_duel_common.lua")
function c100730265.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730265.skill,c100730265.con,aux.Stringid(100730265,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730265.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730265.spcostfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,2,nil)
		and Duel.IsExistingMatchingCard(c100730265.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil)
		and Duel.IsPlayerCanSpecialSummon(tp)
		and Duel.GetMZoneCount(tp)>1
end
function c100730265.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.PayLPCost(tp,1500)
	local rg=Duel.GetMatchingGroup(c100730265.spcostfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,exc)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local sg=rg:SelectSubGroup(tp,c100730265.fgoal,false,2,2,e,tp)
	Duel.Remove(sg,POS_FACEUP,REASON_COST)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c100730265.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	end
	e:Reset()
end
function c100730265.spcostfilter(c)
	return c:IsAbleToRemoveAsCost() and c:IsType(TYPE_MONSTER)
end
function c100730265.fgoal(sg,e,tp)
	return sg:FilterCount(Card.IsRace,nil,RACE_DINOSAUR)==1
		and Duel.IsExistingMatchingCard(c100730265.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,sg,e,tp)
end
function c100730265.filter(c,e,tp)
	return c:IsRace(RACE_DINOSAUR) and c:IsLevelAbove(7) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end