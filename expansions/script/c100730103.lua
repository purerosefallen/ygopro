--高速决斗技能-我永远在你身边
Duel.LoadScript("speed_duel_common.lua")
function c100730103.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730103.skill,c100730103.con,aux.Stringid(100730103,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730103.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil,78371393,4779091,31764700)
end
function c100730103.skill(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,1-tp,100730103)
	local sg=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil,78371393,4779091,31764700)
	local g=sg:Select(tp,1,9,nil)
	Duel.SendtoDeck(g,1-tp,0,REASON_RULE)
	local ct=g:GetCount()
	local g1=Duel.GetDecktopGroup(tp,ct)
	Duel.DisableShuffleCheck()
	Duel.Destroy(g1,REASON_EFFECT)
end