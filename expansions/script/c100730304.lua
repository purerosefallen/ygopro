--高速决斗技能-秘密交换
Duel.LoadScript("speed_duel_common.lua")
function c100730304.initial_effect(c)
	if not c100730304.UsedLP then
		c100730304.UsedLP={}
		c100730304.UsedLP[0]=0
		c100730304.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelAtMainPhase(c,c100730304.skill,c100730304.con,aux.Stringid(100730304,0))
	aux.SpeedDuelMoveCardToFieldCommon(48712195,c)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730304.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,nil)
		and aux.DecreasedLP[tp]-c100730304.UsedLP[tp]>=1000
		and c100730304.UsedLP[tp]<2000
end
function c100730304.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	c100730304.UsedLP[tp]=c100730304.UsedLP[tp]+1000
	Duel.Hint(HINT_CARD,1-tp,100730304)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,1,nil)
	if not g then return end
	Duel.SendtoDeck(g,nil,0,REASON_RULE)
	Duel.ShuffleDeck(tp)
	Duel.Draw(tp,1,REASON_RULE)
end