--高速决斗技能-光之结界
Duel.LoadScript("speed_duel_common.lua")
function c100730064.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730064.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730064.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730064)
	local c=Duel.CreateToken(tp,73206827)
	Duel.SSet(tp,c)
	local d=Duel.CreateToken(tp,62784717)
	Duel.SSet(tp,d)
	e:Reset()
end