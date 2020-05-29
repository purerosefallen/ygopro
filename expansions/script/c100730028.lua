--高速决斗技能-准备决斗！
Duel.LoadScript("speed_duel_common.lua")
function c100730028.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730028.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730028.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local g=GetDecktopGroup(tp,1)
	aux.SpeedDuelSendToHandWithExile(tp,g)
	local g2=GetDecktopGroup(1-tp,1)
	aux.SpeedDuelSendToHandWithExile(1-tp,g2)

	local count=1
	if Duel.GetTurnPlayer()~=tp then
		count=2
	end

	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END,count)
	e1:SetTargetRange(1,0)
	Duel.RegisterEffect(e1,tp,true)

	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetReset(RESET_PHASE+PHASE_END,count)
	Duel.RegisterEffect(e2,tp)

end