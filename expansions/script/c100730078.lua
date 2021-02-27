--高速决斗技能-这不是怪兽！是神！
Duel.LoadScript("speed_duel_common.lua")
function c100730078.initial_effect(c)
	if not c100730078.UsedLP then
		c100730078.UsedLP={}
		c100730078.UsedLP[0]=0
		c100730078.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelAtMainPhase(c,c100730078.skill,c100730078.con,aux.Stringid(100730078,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730078.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,LOCATION_HAND,0,1,nil)
		and aux.DecreasedLP[tp]-c100730078.UsedLP[tp]>=1000
		and c100730078.UsedLP[tp]<2000
end
function c100730078.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	c100730078.UsedLP[tp]=c100730078.UsedLP[tp]+1000
	Duel.Hint(HINT_CARD,1-tp,100730078)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToGrave,tp,LOCATION_HAND,0,1,1,nil)
	if not g then return end
	Duel.SendtoGrave(g,nil,2,REASON_RULE)
	local c=Duel.CreateToken(tp,10000000)
	Duel.SendtoHand(c,nil,REASON_RULE)
end