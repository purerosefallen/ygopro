--高速决斗技能-替罪羊
Duel.LoadScript("speed_duel_common.lua")
function c100730068.initial_effect(c)
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelReplaceDraw(c,c100730068.skill,c100730068.con,aux.Stringid(100730068,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730068.skill(e,tp,eg,ep,ev,re,r,rp)	
	tp = e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730068,0)) then
		local e1=Effect.GlobalEffect()
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_DRAW_COUNT)
		e1:SetTargetRange(1,0)
		e1:SetReset(RESET_PHASE+PHASE_DRAW)
		e1:SetValue(0)
		Duel.RegisterEffect(e1,tp)
		for i=1,3 do
			local token=Duel.CreateToken(tp,73915052)
			Duel.MoveToField(token,tp,tp,LOCATION_MZONE,POS_FACEUP_DEFENSE,true)
			local e2=Effect.CreateEffect(token)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_UNRELEASABLE_SUM)
			e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e2:SetValue(1)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD)
			token:RegisterEffect(e2,true)
		end
		Duel.SkipPhase(tp,PHASE_MAIN1,RESET_PHASE+PHASE_END,1)
		local e3=Effect.GlobalEffect()
		e3:SetType(EFFECT_TYPE_FIELD)
		e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e3:SetTargetRange(1,0)
		e3:SetCode(EFFECT_CANNOT_BP)
		e3:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e3,tp)
		e:Reset()
	end
end
function c100730068.con(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp and aux.DecreasedLP[tp] >= 2000
end