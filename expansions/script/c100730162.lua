--高速决斗技能-恐龙基因
Duel.LoadScript("speed_duel_common.lua")
function c100730162.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730162.skill,c100730162.con,aux.Stringid(100730162,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730162.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetCurrentChain()==0
end

function c100730162.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Recover(tp,350,REASON_EFFECT)   
end