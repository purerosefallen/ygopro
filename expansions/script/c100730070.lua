--高速决斗技能-生命增加α
Duel.LoadScript("speed_duel_common.lua")
function c100730070.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730070.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730070.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730070)
	local lp=Duel.GetLP(tp)
	Duel.SetLP(tp,lp+1500)
	e:Reset()
end