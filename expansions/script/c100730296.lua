--高速决斗技能-装备补充
Duel.LoadScript("speed_duel_common.lua")
function c100730296.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(93671934,c)
	aux.SpeedDuelAtMainPhase(c,c100730296.skill,c100730296.con,aux.Stringid(100730296,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730296.filter1(c)
	return c:IsType(TYPE_EQUIP) and c:IsAbleToDeck()
end

function c100730296.filter2(c)
	return c:IsType(TYPE_EQUIP) and c:IsAbleToHand()
end

function c100730296.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_GRAVE,0,3,nil,TYPE_EQUIP)
		and Duel.IsExistingMatchingCard(c100730296.filter1,tp,LOCATION_GRAVE,0,1,nil)
		and Duel.IsExistingMatchingCard(c100730296.filter2,tp,LOCATION_GRAVE,0,1,nil)
end

function c100730296.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local g1=Duel.GetMatchingGroup(c100730296.filter1,tp,LOCATION_GRAVE,0,nil)
	local g2=Duel.GetMatchingGroup(c100730296.filter2,tp,LOCATION_GRAVE,0,nil)
	if not (g1 and g1:GetCount()>0 and g2 and g2:GetCount()>0) then return end
	local g3=g1:RandomSelect(tp,1)
	g2:Sub(g3)
	Duel.SendtoHand(g3,nil,REASON_RULE)
	Duel.SendtoDeck(g2,nil,2,REASON_RULE)
end