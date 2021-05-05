--高速决斗技能-深海的帝王：No.32
Duel.LoadScript("speed_duel_common.lua")
function c100730132.initial_effect(c)
	aux.SpeedDuelMoveCardToDeckCommon(65676461,c)
	aux.SpeedDuelMoveCardToDeckCommon(49221191,c)
	aux.SpeedDuelMoveCardToDeckCommon(7092142,c)
	if not c100730132.UsedLP then
		c100730132.UsedLP={}
		c100730132.UsedLP[0]=0
		c100730132.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelAtMainPhase(c,c100730132.skill,c100730132.con,aux.Stringid(100730132,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730132.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,84013237)
		and aux.DecreasedLP[tp]-c100730132.UsedLP[tp]>=2000
		and c100730132.UsedLP[tp]<2500
end
function c100730132.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	c100730132.UsedLP[tp]=c100730132.UsedLP[tp]+2000
	Duel.Hint(HINT_CARD,1-tp,100730132)
	local g=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_GRAVE,0,1,1,nil,65676461)
	if not g then return end
	Duel.SendtoDeck(g,nil,2,REASON_RULE)
	local c=Duel.CreateToken(tp,61258740)
	Duel.SendtoHand(c,nil,REASON_RULE)
end