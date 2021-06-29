--高速决斗技能-孤注一掷
Duel.LoadScript("speed_duel_common.lua")
function c100730072.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730072.skill,c100730072.con,aux.Stringid(100730072,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730072.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
	and aux.SpeedDuelAtMainPhaseCondition(e,tp)
	and Duel.GetTurnCount()>=5
	and Duel.GetLP(tp)>100
	and Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,LOCATION_HAND,0,2,nil)
end
function c100730072.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730072)
	local lp=Duel.GetLP(tp)
	Duel.PayLPCost(tp,lp-100)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToGrave,tp,LOCATION_HAND,0,2,2,nil)
	if not g then return end
	Duel.SendtoGrave(g,REASON_COST)
	local d=Duel.TossDice(tp,1)
	Duel.Draw(tp,d,REASON_RULE)
	e:Reset()
end