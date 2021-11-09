--高速决斗技能-最后的任务
Duel.LoadScript("speed_duel_common.lua")
function c100730157.initial_effect(c)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730157.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetLP(tp)<=5000
end
function c100730157.skill(e,tp)
   tp = e:GetLabelObject():GetOwner()
	local g=Group.CreateGroup()
	local lp=Duel.GetLP(tp)
	local count=1
	if Duel.TossCoin(tp,1)==1 or lp<2500 then
		count=3
	end
	while count>0 do
		local c=Duel.CreateToken(tp,66436257)
		g:AddCard(c)
		aux.CardAddedBySkill:AddCard(c)
		Duel.SendtoGrave(g,REASON_RULE)
		count=count-1
	end
	e:Reset()
end