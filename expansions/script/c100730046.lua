--高速决斗技能-神圣护卫
Duel.LoadScript("speed_duel_common.lua")
function c100730046.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730046.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730046.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_REVERSE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(c100730046.abdcon)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end

function c100730046.abdcon(e)
	return Duel.GetTurnPlayer()==e:GetHandlerPlayer()
end