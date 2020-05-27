--高速决斗技能-生命增加α
Duel.LoadScript("speed_duel_common.lua")
function c100730021.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730021.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730021.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local lp=Duel.GetLP(tp)
	Duel.SetLP(tp,lp+1000)
	e:Reset()
end