--高速决斗技能-梦幻的手卡
Duel.LoadScript("speed_duel_common.lua")
function c100730141.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730141.operation,c100730141.con,aux.Stringid(100730141,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730141.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,nil)
		and Duel.GetMZoneCount(tp)>0
		and Duel.GetLP(tp)+2000<=Duel.GetLP(1-tp)
		and Duel.IsPlayerCanSpecialSummon(tp)
end
function c100730141.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToGrave,tp,LOCATION_HAND,0,nil)
	local g1=g:Select(tp,1,3,nil)
	if not g1 then return end
	Duel.SendtoDeck(g1,tp,0,REASON_RULE)
	Duel.Hint(HINT_CARD,1-tp,100730141)
	local ct=g1:GetCount()
	if ct==1 then
		local c=Duel.CreateToken(tp,18724123)
		Duel.SpecialSummon(c,0,tp,tp,true,true,POS_FACEUP)
	elseif ct==2 then
		local c=Duel.CreateToken(tp,56209279)
		Duel.SpecialSummon(c,0,tp,tp,true,true,POS_FACEUP)
	elseif ct==3 then
		local c=Duel.CreateToken(tp,66957584)
		Duel.SendtoHand(c,nil,REASON_RULE)
	end
end