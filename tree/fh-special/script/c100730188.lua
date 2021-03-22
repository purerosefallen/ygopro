--高速决斗技能-放马过来
Duel.LoadScript("speed_duel_common.lua")
function c100730188.initial_effect(c)
	if not c100730188.UsedLP then
		c100730188.UsedLP={}
		c100730188.UsedLP[0]=0
		c100730188.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelAtMainPhase(c,c100730188.skill,c100730188.con,aux.Stringid(100730188,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730188.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,nil)
		and aux.DecreasedLP[tp]-c100730188.UsedLP[tp]>=1000
end
function c100730188.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	c100730188.UsedLP[tp]=c100730188.UsedLP[tp]+1000
	Duel.Hint(HINT_CARD,1-tp,100730188)
	local g1=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,1,nil)
	if not g1 then return end
	Duel.SendtoDeck(g1,nil,2,REASON_RULE)
	local g=Duel.GetMatchingGroup(c100730188.Dfilter,tp,LOCATION_DECK,0,nil)
	local c=g:Select(tp,1,1,nil)
	Duel.SendtoHand(c,nil,REASON_RULE)
end
function c100730188.Dfilter(c)
	return c:IsAttribute(ATTRIBUTE_DARK) and c:IsLevel(8) and c:IsRace(RACE_WARRIOR)
end