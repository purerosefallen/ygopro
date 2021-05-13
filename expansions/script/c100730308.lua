--高速决斗技能-骰子回复
Duel.LoadScript("speed_duel_common.lua")
function c100730308.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(39454112,c)
	aux.SpeedDuelAtMainPhase(c,c100730308.skill,c100730308.con,aux.Stringid(100730308,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730308.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
end
function c100730308.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730308)
	local ct=Duel.TossDice(tp,1)
	Duel.Recover(tp,ct*200,REASON_EFFECT)
	local g1=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE,0,0,1,nil,43061293)
	Duel.SendtoHand(g1,tp,REASON_RULE)
	if ct==1 or ct==6 then return end
	e:Reset()
end