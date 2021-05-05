--高速决斗技能-场地补充
Duel.LoadScript("speed_duel_common.lua")
function c100730142.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(87624166,c)
	aux.SpeedDuelAtMainPhase(c,c100730142.skill,c100730142.con,aux.Stringid(100730142,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730142.filter1(c)
	return c:IsType(TYPE_FIELD) and c:IsAbleToDeck()
end

function c100730142.filter2(c)
	return c:IsType(TYPE_FIELD) and c:IsAbleToHand()
end

function c100730142.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_GRAVE,0,3,nil,TYPE_FIELD)
		and Duel.IsExistingMatchingCard(c100730142.filter1,tp,LOCATION_GRAVE,0,1,nil)
		and Duel.IsExistingMatchingCard(c100730142.filter2,tp,LOCATION_GRAVE,0,1,nil)
end

function c100730142.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local g1=Duel.GetMatchingGroup(c100730142.filter1,tp,LOCATION_GRAVE,0,nil)
	local g2=Duel.GetMatchingGroup(c100730142.filter2,tp,LOCATION_GRAVE,0,nil)
	if not (g1 and g1:GetCount()>0 and g2 and g2:GetCount()>0) then return end
	local g3=g1:RandomSelect(tp,1)
	g2:Sub(g3)
	Duel.SendtoHand(g3,nil,REASON_EFFECT)
	Duel.SendtoDeck(g2,nil,2,REASON_EFFECT)
end