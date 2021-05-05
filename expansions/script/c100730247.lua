--高速决斗技能-以卡换血
Duel.LoadScript("speed_duel_common.lua")
function c100730247.initial_effect(c)
	aux.SpeedDuelReplaceDraw(c,c100730247.skill,c100730247.con,aux.Stringid(100730247,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730247.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and Duel.GetTurnCount()>=2
end
function c100730247.skill(e,tp,eg,ep,ev,re,r,rp)	
	tp=e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730247,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730247)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_DRAW_COUNT)
		e1:SetTargetRange(1,0)
		e1:SetReset(RESET_PHASE+PHASE_DRAW)
		e1:SetValue(0)
		Duel.RegisterEffect(e1,tp)
		Duel.Recover(tp,1500,REASON_EFFECT)
	end
end