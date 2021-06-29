--高速决斗技能-决斗饭团
Duel.LoadScript("speed_duel_common.lua")
function c100730138.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730138.skill,c100730138.con,aux.Stringid(100730138,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730138.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetLP(tp)<Duel.GetLP(1-tp)
end
function c100730138.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	if not Duel.SelectYesNo(tp,aux.Stringid(100730138,0)) then return end
	Duel.Hint(HINT_CARD,1-tp,100730138)
	Duel.Recover(tp,1000,REASON_EFFECT)   
end