--高速决斗技能-盗贼
Duel.LoadScript("speed_duel_common.lua")
function c100730073.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730073.skill,c100730073.con,aux.Stringid(100730073,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730073.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetTurnCount(tp)==2
		and ct>2
		and Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_DECK,0,ct-2,nil,0xb)
end
function c100730073.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730073)
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)-2
	if ct<=0 then return end
	local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_HAND,0,ct,ct,nil)
	Duel.SendtoGrave(g,REASON_RULE+REASON_DISCARD)
	local g2=Duel.SelectMatchingCard(tp,Card.IsSetCard,tp,LOCATION_DECK,0,ct,ct,nil,0xb)
	Duel.SendtoGrave(g2,REASON_RULE)
	e:Reset()
end
