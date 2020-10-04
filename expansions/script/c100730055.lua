--高速决斗技能-秘密交换
Duel.LoadScript("speed_duel_common.lua")
function c100730055.initial_effect(c)
	if not c100730055.UsedLP then
		c100730055.UsedLP={}
		c100730055.UsedLP[0]=0
		c100730055.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelAtMainPhase(c,c100730055.skill,c100730055.con,aux.Stringid(100730055,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730055.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,nil)
		and aux.DecreasedLP[tp]-c100730055.UsedLP[tp]>=1000
		and c100730055.UsedLP[tp]<2000
end
function c100730055.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	c100730055.UsedLP[tp]=c100730055.UsedLP[tp]+1000
	Duel.Hint(HINT_CARD,1-tp,100730055)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,1,nil)
	if not g then return end
	Duel.SendtoDeck(g,nil,2,REASON_RULE)
	local c=Duel.CreateToken(tp,24094653)
	Duel.SendtoHand(c,nil,REASON_RULE)
end