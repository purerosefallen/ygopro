--高速决斗技能-龙之融合
Duel.LoadScript("speed_duel_common.lua")
function c100730106.initial_effect(c)
	aux.SpeedDuelMoveCardToDeckCommon(99267150,c)
	aux.SpeedDuelMoveCardToDeckCommon(71490127,c)
	if not c100730106.UsedLP then
		c100730106.UsedLP={}
		c100730106.UsedLP[0]=0
		c100730106.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelAtMainPhase(c,c100730106.skill,c100730106.con,aux.Stringid(100730106,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730106.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,nil)
		and aux.DecreasedLP[tp]-c100730106.UsedLP[tp]>=1500
		and c100730106.UsedLP[tp]<2000
end
function c100730106.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	c100730106.UsedLP[tp]=c100730106.UsedLP[tp]+1500
	Duel.Hint(HINT_CARD,1-tp,100730106)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,1,nil)
	if not g then return end
	Duel.SendtoDeck(g,nil,2,REASON_RULE)
	local c=Duel.CreateToken(tp,71490127)
	Duel.SendtoHand(c,nil,REASON_RULE)
end