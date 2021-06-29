--高速决斗技能-融合大师
Duel.LoadScript("speed_duel_common.lua")
function c100730317.initial_effect(c)
	if not c100730317.UsedLP then
		c100730317.UsedLP={}
		c100730317.UsedLP[0]=0
		c100730317.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelAtMainPhase(c,c100730317.skill,c100730317.con,aux.Stringid(100730317,0))
	aux.SpeedDuelMoveCardToFieldCommon(30548775,c)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730317.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,nil)
		and aux.DecreasedLP[tp]-c100730317.UsedLP[tp]>=1000
		and c100730317.UsedLP[tp]<2000
end
function c100730317.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	c100730317.UsedLP[tp]=c100730317.UsedLP[tp]+1000
	Duel.Hint(HINT_CARD,1-tp,100730317)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,1,nil)
	if not g then return end
	Duel.SendtoDeck(g,nil,2,REASON_RULE)
	local c=Duel.CreateToken(tp,24094653)
	Duel.SendtoHand(c,nil,REASON_RULE)
end