--高速决斗技能-噩梦呈现
Duel.LoadScript("speed_duel_common.lua")
function c100730048.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730048.skill,c100730048.con,aux.Stringid(100730048,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730048.filter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end

function c100730048.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_GRAVE,0,3,nil,TYPE_SPELL)
		and Duel.IsExistingMatchingCard(c100730048.filter,tp,LOCATION_GRAVE,0,1,nil)
end

function c100730048.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local g1=Duel.GetMatchingGroup(c100730048.filter,tp,LOCATION_GRAVE,0,nil)
	if not (g1 and g1:GetCount()>0) then return end
	local g2=g1:RandomSelect(tp,1)
	Duel.SendtoHand(g3,nil,REASON_RULE)
	e:Reset()
end