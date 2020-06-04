--高速决斗技能-秘密交换
Duel.LoadScript("speed_duel_common.lua")
function c100730052.initial_effect(c)
	if not c100730052.UsedLP then
		c100730052.UsedLP={}
		c100730052.UsedLP[0]=0
		c100730052.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelAtMainPhase(c,c100730052.skill,c100730052.con,aux.Stringid(100730052,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730052.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,nil)
		and aux.DecreasedLP[tp]-c100730052.UsedLP[tp]>=1000
		and c100730052.UsedLP[tp]<2000
end
function c100730052.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	c100730052.UsedLP[tp]=c100730052.UsedLP[tp]+1000
	Duel.Hint(HINT_CARD,1-tp,100730052)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,1,nil)
	if not g then return end
	Duel.SendtoDeck(g,nil,2,REASON_RULE)
	Duel.Draw(tp,1,REASON_RULE)
end