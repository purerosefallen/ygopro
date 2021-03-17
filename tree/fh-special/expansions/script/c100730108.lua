--高速决斗技能-决斗饭团
Duel.LoadScript("speed_duel_common.lua")
function c100730108.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730108.skill,c100730108.con,aux.Stringid(100730108,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730108.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetLP(tp)<Duel.GetLP(1-tp)
end
function c100730108.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Recover(tp,1000,REASON_EFFECT)   
end